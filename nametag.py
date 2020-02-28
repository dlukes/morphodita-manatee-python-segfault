import ufal.nametag as nt


def run(text, log):
    model = nt.Ner.load("czech-cnec2.0-140304.ner")
    tokenizer = model.newTokenizer()
    forms = nt.Forms()
    tokens = nt.TokenRanges()
    entities = nt.NamedEntities()
    log.info("    calling .setText")
    tokenizer.setText(text)
    log.info("    calling .nextSentence")
    while tokenizer.nextSentence(forms, tokens):
        log.info("    calling .recognize")
        model.recognize(forms, entities)
        log.info("-" * 72)
        for entity in entities:
            start = entity.start
            end = entity.start + entity.length
            form = " ".join(forms[start:end])
            log.info("%s: %s", entity.type, form)
        log.info("-" * 72)
