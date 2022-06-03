package main

import (
	"fmt"

	"github.com/m1gwings/treedrawer/tree"
)

type History struct {
	iteratioin  int
	person      string
	fights_with *string
	points      int
	equip       string
	died        *int
}

func main() {

	db := NewSQLBase(
		"localhost",
		"5432",
		"binarycat",
		"12345",
		"shiza")
	defer db.Close()

	db.LoadData()
	db.CreateStructure()
	db.GenerateData()
	i := 0
	for ; i < 5; i++ {
		db.ExecCommandArgs("links", "gendata", []string{fmt.Sprint(i)})
		db.ExecCommandArgs("linkweights", "gendata", []string{fmt.Sprint(i)})
		db.PrepareFight()
		db.ExecCommandArgs("save", "history", []string{fmt.Sprint(i)})
		db.Fight()
		db.Upgrade()
	}
	db.Cleanup()
	db.ExecCommandArgs("save", "history", []string{fmt.Sprint(i)})

	_, rows, err := db.ExecQuery(
		"SELECT * FROM history ORDER BY iteration", []string{})
	if err != nil {
		fmt.Println(err)
	}
	defer rows.Close()

	var history [][]History
	currentIter := -1
	for rows.Next() {
		h := &History{}
		err := rows.Scan(&h.iteratioin, &h.person, &h.fights_with, &h.points, &h.equip, &h.died)
		if err != nil {
			fmt.Println("Scanning error", err)
		}
		if currentIter != h.iteratioin {
			currentIter++
			history = append(history, []History{})
		}

		if err != nil {
			fmt.Println(err)
		}

		history[len(history)-1] = append(history[len(history)-1], *h)
	}

	winners := []History{}
	for _, h := range history[len(history)-1] {
		if h.died == nil {
			winners = append(winners, h)
		}
	}

	t := tree.NewTree(tree.NodeString("Выжившие"))

	for _, w := range winners {
		_, rows, err = db.ExecQuery(
			"SELECT statname, stattype FROM person_links WHERE personname = $1 ORDER BY stattype", []string{w.person})
		if err != nil {
			fmt.Println("Query error", err)
		}
		defer rows.Close()

		var statname string
		var stattype string

		fmt.Println("Победитель:", w.person)
		for rows.Next() {
			err := rows.Scan(&statname, &stattype)
			if err != nil {
				fmt.Println("Scanning error", err)
			}
			fmt.Println(stattype, statname)
		}
		fmt.Println()
		Draw([]History{w}, history[:len(history)-1], t)
	}
	fmt.Println(t)
}

func Draw(winners []History, history [][]History, node *tree.Tree) {
	if len(history) == 0 {
		return
	}
	for _, w := range winners {
		n := node.AddChild(tree.NodeString(fmt.Sprint(w.person, " ", w.points, " ", w.equip)))

		p1 := History{}
		p2 := History{}

		for _, h := range history[len(history)-1] {
			if h.person == w.person {
				p1 = h
			}

			if w.fights_with != nil && h.person == *w.fights_with {
				p2 = h
			}

		}

		if p2.person == "" {
			Draw([]History{p1}, history[:len(history)-1], n)
		} else {
			Draw([]History{p1, p2}, history[:len(history)-1], n)
		}
	}
}
