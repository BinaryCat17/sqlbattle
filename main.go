package main

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
	for i := 1; i <= 10; i++ {
		db.PrepareFight()
		db.Fight()
		db.Upgrade()
	}
	db.Cleanup()
}
