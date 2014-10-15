index:
	markdown Readme.md > index.html

fix_artsmia_org_links:
	sed -i 's|http://www.artsmia.org/|http://artsmia.github.io/ancient-pages/1/|' 2/*.html

point_relative_links_to_github:
	sed -i 's|\(href="\)|\1http://artsmia.github.io/ancient-pages/2/|g' 2/intro.html

# I'm using too much tilde disk, so punt everything over to github
strip_unneccessary_pages_and_assets:
	mv 2{,.old}
	mkdir -p 2/images
	mv 2.old/intro.html 2/
	mv 2.old/images/in[kiosk,dept,web,vid,title]*
	mv 2.old/images/in[kiosk,dept,web,vid,title]* 2/images/
	mv 2.old/images/title.gif 2/images/
