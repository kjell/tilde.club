tildes:
	ls /home | while read user; do \
		finger -lm $$user > $$user.finger; \
	done

tildes.json: tildes
	@for finger in *.finger; do \
		user=$$(basename $$finger .finger); \
		name=$$(grep Name: < $$finger | rev | cut -d' ' -f1-2 | rev); \
		plan=$$(sed '0,/^Plan:/d' < $$finger); \
		jq -c -n --arg login $$user --arg name "$$name" --arg plan "$$plan" '{login: $$login, name: $$name, plan: $$plan}'; \
	done | jq -s '.' > tildes.json

update:
	while true; do \
		rm tildes.json; make tildes.json; \
		make plans.atom | grep -v 'make\[1\]:' > plans.atom; \
		sleep 300; \
	 done

updated=$$(ls -t /home/*/.plan | head -1 | xargs ls -la --time-style=long-iso | cut -d' ' -f6-7 | xargs -0 date +"%FT%TZ" -d)
plans.atom:
	@echo '<?xml version="1.0" encoding="utf-8"?><feed xmlns="http://www.w3.org/2005/Atom"><title>~.club.plans</title><id>http://tilde.club/</id><author><name>~kjell</name><email>kjell@tilde.club</email></author><link href="http://tilde.club/~kjell/tildes/plans.atom" rel="self"/><updated>'$(updated)'</updated>'
	@for user in $$(ls -t /home/*/.plan); do \
		ls="$$(ls -la --time-style=long-iso "$$user")"; \
		user="$$(cut -d' ' -f3 <<< $$ls)"; \
		updated=$$(cut -d' ' -f6-7 <<< $$ls | xargs -0 date +"%FT%TZ" -d); \
		plan=$$(cat "/home/$$user/.plan" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g'); \
		echo "<entry><id>http://tilde.club/~$$user/.plan</id><title>$$user</title><link href=\"http://tilde.club/~$$user\"/><updated>$$updated</updated><content type=\"html\">&lt;pre&gt;$$plan&lt;/pre&gt;</content></entry>"; \
	done
	@echo "</feed>"

plans:
	for user in $$(ls /home); do plan="/home/$$user/.plan"; [[ -f "$$plan" ]] && cp $$plan plans/$$user; done

.PHONY: plans plans.atom tildes.json
