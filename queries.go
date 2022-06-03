package main

func (d *SQLBase) LoadData() {
	d.ExecCommand("clear", "loaddata")
	d.ExecCommand("tablenames", "loaddata")
	d.ExecCommand("tablepool", "loaddata")
	d.ExecShell("readnames", "loaddata")
	d.ExecShell("readpool", "loaddata")
}

func (d *SQLBase) CreateStructure() {
	d.ExecCommand("clear", "maketables")
	d.ExecCommand("stats", "maketables")
	d.ExecCommand("persons", "maketables")
	d.ExecCommand("links", "maketables")
	d.ExecCommand("person_links", "maketables")
	d.ExecCommand("fight_results", "maketables")
	d.ExecCommand("history", "maketables")
}

func (d *SQLBase) GenerateData() {
	d.ExecCommand("names", "gendata")
	d.ExecCommand("specs", "gendata")
	d.ExecCommand("skills", "gendata")
	d.ExecCommand("equip", "gendata")
	d.ExecCommand("attrs", "gendata")
	d.ExecCommand("epohs", "gendata")
	d.ExecCommand("personlinks", "gendata")
}

func (d *SQLBase) PrepareFight() {

	d.ExecCommand("shuffledied", "preparefight")
	d.ExecCommand("calcpoints", "preparefight")
	d.ExecCommand("removeweaks", "preparefight")
	d.ExecCommand("removeclones", "preparefight")
	d.ExecCommand("revivedied", "preparefight")
	d.ExecCommand("dieiteration", "preparefight")
}

func (d *SQLBase) Fight() {
	d.ExecCommand("clear", "fight")
	d.ExecCommand("pairup", "fight")
	d.ExecCommand("kill", "fight")
}

func (d *SQLBase) Upgrade() {
	d.ExecCommand("swapequip", "upgrade")
	d.ExecCommand("makeclones", "upgrade")
	d.ExecCommand("linkclones", "upgrade")
	d.ExecCommand("clear", "upgrade")
}

func (d *SQLBase) Cleanup() {
	d.ExecCommand("calcpoints", "preparefight")
	d.ExecCommand("removeweaks", "preparefight")
	d.ExecCommand("removeclones", "preparefight")
}
