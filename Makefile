# SPDX-License-Identifier: MIT

BASE_URL=https://android.googlesource.com

all:

data/repos.txt:
	mkdir -p data
	wget -q ${BASE_URL}/?format=TEXT -O $@

data/git:
	mkdir -p $@
	cd $@ && git init

data/%/tag-message: data/git data/repos.txt
	mkdir -p $$(dirname $@)
	rm -f $@
	touch $@
	echo $%
	for repo in $$(cat data/repos.txt | sort); do \
		(cd $< && git fetch --depth=1 --filter=blob:none ${BASE_URL}/$$repo $$(echo $@ | sed 's/data\///g' | sed 's/\/tag-message//g')); \
		if [ $$? -eq 0 ] ; then \
			echo REPO: $$repo >> $@; \
			(cd $< && git cat-file -p $$(cat .git/FETCH_HEAD | cut -c -40)) >> $@ ; \
		fi; \
	done

.PHONY: tag-message
.NOTPARALLEL: tag-message
tag-message: data/refs/tags/android-15.0.0_r0.1/tag-message data/refs/tags/android-15.0.0_r0.2/tag-message data/refs/tags/android-15.0.0_r0.3/tag-message

.PHONY: summary
summary:
	@for file in data/refs/tags/*; do \
		echo FILE $$file; \
		grep ^Android $$file/tag-message | sort | uniq -c; \
	done


data/refs/tags/%/repos-with-tag-message:  data/refs/tags/%/tag-message
	grep -e '^REPO\|^Android' $<  > $@

.PHONY: repos-with-tag-message
repos-with-tag-message: data/refs/tags/android-15.0.0_r0.1/repos-with-tag-message  data/refs/tags/android-15.0.0_r0.2/repos-with-tag-message data/refs/tags/android-15.0.0_r0.3/repos-with-tag-message

data/refs/tags/%/repos-with-wrong-tag: data/refs/tags/%/tag-message
	scripts/get-broken-repos.py $< >$@

.PHONY: repos-with-wrong-tag
repos-with-wrong-tag: data/refs/tags/android-15.0.0_r0.2/repos-with-wrong-tag

.PHONY: clean
clean:
	rm -rf data/
