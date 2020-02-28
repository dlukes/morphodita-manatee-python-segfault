import ufal.morphodita as md


def run(text, log):
    tagger = md.Tagger.load("czech-morfflex-pdt-161115.tagger")
    tokenizer = tagger.newTokenizer()
    forms = md.Forms()
    tokens = md.TokenRanges()
    lemmas = md.TaggedLemmas()
    log.info("    calling .setText")
    tokenizer.setText(text)
    log.info("    calling .nextSentence")
    while tokenizer.nextSentence(forms, tokens):
        log.info("    calling .tag")
        tagger.tag(forms, lemmas)
        log.info("-" * 72)
        for word, lemma in zip(forms, lemmas):
            log.info("%s\t%s\t%s", word, lemma.lemma, lemma.tag)
        log.info("-" * 72)
