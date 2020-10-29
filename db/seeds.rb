tournament = Category.create(name: "第99回全国高校野球選手権大会")
school1 = tournament.children.create([{name: "滝川西"},{name: "北海"},{name: "青森山田"},{name: "盛岡大付"},
                                      {name: "明桜"},{name: "日大山形"},{name: "仙台育英"},{name: "聖光学院"},
                                      {name: "土浦日大"},{name: "作新学院"},{name: "前橋育英"},{name: "花咲徳栄"},
                                      {name: "木更津総合"},{name: "二松学舎大付"},{name: "東海大菅生"},{name: "横浜"},
                                      {name: "山梨学院"},{name: "藤枝明誠"},{name: "中京大中京"},{name: "大垣日大"},
                                      {name: "津田学園"},{name: "日本文理"},{name: "松商学園"},{name: "高岡商業"},
                                      {name: "日本航空石川"},{name: "坂井"},{name: "彦根東"},{name: "京都成章"},
                                      {name: "大阪桐蔭"},{name: "神戸国際大付"},{name: "天理"},{name: "智弁和歌山"},
                                      {name: "おかやま山陽"},{name: "広陵"},{name: "米子松蔭"},{name: "開星"},
                                      {name: "下関国際"},{name: "三本松"},{name: "鳴門渦潮"},{name: "済美"},
                                      {name: "明徳義塾"},{name: "東筑"},{name: "早稲田佐賀"},{name: "波佐見"},
                                      {name: "秀岳館"},{name: "明豊"},{name: "聖心ウルスラ"},{name: "神村学園"},
                                      {name: "興南"}])

tournament2 = Category.create(name: "第100回全国高校野球選手権記念大会")
school1 = tournament2.children.create([{name: "旭川大高"},{name: "北照"},{name: "八戸学院光星"},{name: "花巻東"},
                                       {name: "金足農業"},{name: "羽黒"},{name: "仙台育英"},{name: "聖光学院"},
                                       {name: "土浦日大"},{name: "作新学院"},{name: "前橋育英"},{name: "花咲徳栄"},
                                       {name: "浦和学院"},{name: "木更津総合"},{name: "中央学院"},{name: "二松学舎学舎大付"},
                                       {name: "日大三"},{name: "慶応"},{name: "横浜"},{name: "山梨学院"},
                                       {name: "常葉大菊川"},{name: "愛産大三河"},{name: "愛工大名電"},{name: "大垣日大"},
                                       {name: "白山"},{name: "中越"},{name: "佐久長聖"},{name: "高岡商業"},
                                       {name: "星稜"},{name: "敦賀気比"},{name: "近江"},{name: "龍谷大平安"},
                                       {name: "大阪桐蔭"},{name: "近大付"},{name: "報徳学園"},{name: "明石商業"},
                                       {name: "奈良大付"},{name: "智弁和歌山"},{name: "創志学園"},{name: "広陵"},
                                       {name: "鳥取城北"},{name: "益田東"},{name: "下関国際"},{name: "丸亀城西"},
                                       {name: "鳴門"},{name: "済美"},{name: "高知商業"},{name: "折尾愛真"},
                                       {name: "沖学園"},{name: "佐賀商業"},{name: "創成館"},{name: "東海大熊本星翔"},
                                       {name: "藤蔭"},{name: "日南学園"},{name: "鹿児島実業"},{name: "興南"}])
                                       
User.create!(nickname: "yakumo",
             email: ENV['EMAIL'],
             password: ENV['PASSWORD'],
             password_confirmation: ENV['PASSWORD'] ,
             admin: true)