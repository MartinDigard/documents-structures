# Martin Digard

import csv
from lxml import etree


def read_csv(file):
    content = []
    with open(file) as input:
        reader = csv.DictReader(input, delimiter=';')
        for item in reader:
            content.append(item)
    return content


def xml_base(xml_content):
    base_xml = []
    base_xml.append('<?xml version="1.0" encoding="utf-8" standalone="no"?>')
    base_xml.append('<!DOCTYPE toilettes SYSTEM "wc.dtd">')
    base_xml.append(xml_content)
    return base_xml


def xml_rules(csv_data):
    root = etree.Element("toilettes")
    for l in csv_data:
        princ_child = etree.SubElement(root, "toilette", type=l['TYPE'], statut=l['STATUT'])
        child1 = etree.SubElement(princ_child, "adresse")
        lite1_child1 = etree.SubElement(child1, "libelle")
        lite1_child1.text = l['ADRESSE']
        lite2_child1 = etree.SubElement(child1, "arrondissement")
        lite2_child1.text = l['ARRONDISSEMENT']
        child2 = etree.SubElement(princ_child, "horaire")
        child2.text = l['HORAIRE']
        child3 = etree.SubElement(princ_child, "services")
        lite1_child3 = etree.SubElement(child3, "acces-pmr")
        lite1_child3.text = l['ACCES_PMR']
        lite2_child3 = etree.SubElement (child3, "relais-bebe")
        lite2_child3.text = l['RELAIS_BEBE']
        child4 = etree.SubElement(princ_child, "equipement")
        child4.text = l['URL_FICHE_EQUIPEMENT']
    data = etree.tostring(root, pretty_print=True).decode('utf-8')
    return data


def csv_to_xml(csv_file):
    csv_data = read_csv(csv_file)
    rules = xml_rules(csv_data)
    xml_data = xml_base(rules)
    xml = '\n'.join(xml_data)
    return xml 


if __name__ == "__main__":

    with open('toilettes-paris.xml','w') as f:
        print(csv_to_xml('sanisettesparis.csv'), file=f)

