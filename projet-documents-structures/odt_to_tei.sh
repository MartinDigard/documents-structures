# Martin Digard

input=transformation/input/
output=transformation/output/

# Réinitialiser le contenu du répertoire de sortie à chaque lancement.
if [ `ls -a $output | wc -l` -gt 2 ]
then
	rm -f -r $output*
fi

# Ouvrir les archives.
for file in `ls $input`
do
	output_file=`echo "$file" | cut -d "." -f1`

	unzip -qq $input$file -d $output$output_file
done

# Générer et valider les TEI et ne garder que les TEI dans le fichier d’output.
for unziped_odt in `ls $output`
do
	sed -i "s/unziped_odt/$unziped_odt/" transformation/transformation.xsl
	java -jar ~/saxon/saxon-he-10.3.jar $output$unziped_odt/meta.xml transformation/transformation.xsl > $output$unziped_odt.xml
	sed -i "s/$unziped_odt/unziped_odt/" transformation/transformation.xsl
	rm -r $output$unziped_odt
	xmllint --noout -relaxng transformation/schema/tei.rng $output$unziped_odt.xml
done

