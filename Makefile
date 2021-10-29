
PYTHON_DIR=venv/bin
PYTHON=$(PYTHON_DIR)/python
PIP=$(PYTHON_DIR)/pip

GENERATE=generate/generic.py

SQLS=$(wildcard generate/*.sql)
GENERATED=$(foreach sql,$(SQLS),web/data/generated/$(basename $(notdir $(sql))).json)

all: generated

$(PYTHON):
	python3 -m venv venv
	$(PYTHON) -m pip install --upgrade pip
	$(PIP) install -r requirements.txt

web/data/generated/%.json: generate/$(basename $(notdir %)).sql $(PYTHON) $(GENERATE)
	$(PYTHON) $(GENERATE) $< $@

generated: $(GENERATED)
