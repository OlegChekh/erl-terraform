Name="CodingTask"
primaryKey=["columnA","String"]
primarySort=["columnB","Number"]
secondaryKey=["columnA","String"]
secondarySort=["columnC","String"]
secondaryProjection=["columnD","columnE"]
fixture = <<FIXT
columnA, columnB, columnC, columnD, columnE
tripA, 0, tile1, 12, 12
tripA, 1, tile21, 13, 13
tripB, 0, tile1, -12, -12
tripB, 1, tile21, -13, -13
FIXT
