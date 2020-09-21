tournament = Category.create(name: "第99回全国高校野球選手権")
school1 = tournament.children.create([{name: "東邦"},{name: "鳥取城北"}])
tournament2 = Category.create(name: "第100回全国高校野球選手権")
school1 = tournament2.children.create([{name: "広陵"},{name: "関西"}])