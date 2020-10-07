from lxml import etree
import mysql.connector
import os

db = None
products = []

class Product:
    def __init__(self, product_id, brand_id, sku, desc, cost, price_list, core, position, imc_sku, weight, pack_qty, qty_req, warranty, desc_large, features, product_path, product_info, product_desc, product_feat):
        self.product_id = product_id
        self.brand_id = brand_id
        self.sku = sku
        self.desc = desc
        self.cost = cost
        self.price_list = price_list
        self.core = core
        self.position = position
        self.imc_sku = imc_sku
        self.weight = weight
        self.pack_qty = pack_qty
        self.qty_req = qty_req
        self.warranty = warranty
        self.desc_large = desc_large
        self.features = features
        self.product_path = product_path
        self.product_info = product_info
        self.product_desc = product_desc
        self.product_feat = product_feat


def mysql_conn():
    global db
    try:
        db = mysql.connector.connect(host="localhost", user="root", password="", database="imc")
    except mysql.connector.Error as err:
        print("Error: ".format(err))


def mysql_function(qry):
    r = None
    try:
        cur = db.cursor()
        cur.execute(qry)
        (r,) = cur.fetchone()
    except mysql.connector.Error as err:
        print('Error' + err)

    return r


def mysql_procedure(sp, args):
    r = None
    try:
        cur = db.cursor()
        r = cur.callproc(sp, args)
        db.commit()
    except mysql.connector.Error as err:
        db.rollback()

    return r


def find_by_part_number(path_file):
    try:
        with open(path_file, 'r') as file:
            parser = etree.XMLParser(recover=True, encoding='utf-8')
            document = etree.fromstring(file.read().encode('utf-8'), parser)
            file.close()

            print(document)
            for header in document.iter('Header'):
                ItemLevelGTIN = header.find('PIESVersion').text
                SubmissionType = header.find('SubmissionType').text
                ParentAAIAID = header.find('ParentAAIAID').text
                BrandOwnerAAIAID = header.find('BrandOwnerAAIAID').text
                LanguageCode = header.find('LanguageCode').text

            for items in document.iter('Items'):
                for item in items:
                    products = []

                    PartNumber = item.find('PartNumber').text
                    BrandAAIAID = item.find('BrandAAIAID').text

                    #for description in item.find('Descriptions'):
                        #description = description.text

                    brand_id = mysql_function("select sps_brand_v2('" + BrandAAIAID + "')")

                    if brand_id == 0:
                        brand_id = mysql_procedure('spi_brand_v2', (BrandAAIAID, '', 0))[-1]

                    product_id = mysql_function("select sps_product_v2('" + PartNumber + "', '" + BrandAAIAID + "')")

                    if product_id == 0:
                        products.append(Product(0, brand_id, PartNumber, '', 0, 0, '', '', '', 0, '', 0, '', '', '', '', '', '', ''))
                    else:
                        products.append(Product(product_id, '', '', '', '', '', '', '', '', 0, '', 0, '', '', '', '', '', '', ''))

                    for replacements in item.iter('PartInterchangeInfo'):
                        for replacement in replacements:
                            _BrandAAIAID = replacement.find('BrandAAIAID').text #replacement.attrib['BrandAAIAID']
                            _PartNumber = ''.join(e for e in replacement.find('PartNumber').text if e.isalnum())

                            _brand_id = mysql_function("select sps_brand_v2('" + _BrandAAIAID + "')")

                            if _brand_id == 0:
                                _brand_id = mysql_procedure('spi_brand_v2', (_BrandAAIAID, '', 0))[-1]

                            _product_id = mysql_function("select sps_product_v2('" + _PartNumber + "', '" + _BrandAAIAID + "')")

                            if _product_id == 0:
                                products.append(Product(0, _brand_id, _PartNumber, '', 0, 0, '', '', '', 0, '', 0, '', '', '', '', '', '',''))
                            else:
                                products.append(Product(_product_id, '', '', '', '', '', '', '', '', 0, '', 0, '', '', '', '', '', '', ''))

                    for obj in products:
                        if obj.product_id == 0:
                            product_id = mysql_procedure('spi_product', (obj.brand_id, obj.sku, obj.desc, obj.cost, obj.price_list, obj.core, obj.position, obj.imc_sku,obj.weight, obj.pack_qty, obj.qty_req, obj.warranty, obj.desc_large, obj.features, obj.product_path, 0))[-1]
                            obj.product_id = product_id

                    mysql_procedure('spi_parts_replacements', (','.join(str(x.product_id) for x in products),))
    except Exception:
        print("Ocurrió un error procesando" + path_file)
        pass

def main():
    result = [os.path.join(dp, f) for dp, dn, filenames in os.walk("pies/ra_data") for f in filenames if os.path.splitext(f)[1] == '.xml' and not ("aces") in os.path.splitext(f)[0].lower()]
    for file in result:
        print('Ejecución para: ' + file)
        find_by_part_number(file.replace('\\', '/'))


mysql_conn()
main()