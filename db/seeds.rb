tournament3 = Category.create(name: "第91回選抜高校野球大会")
school1 = tournament3.children.create([{name: "札幌大谷"},{name: "札幌第一"},{name: "八戸学院光星"},
                                      {name: "盛岡大付"},{name: "春日部共栄"},{name: "習志野"},{name: "桐蔭学園"},
                                      {name: "山梨学院"},{name: "横浜"},{name: "国士舘"},{name: "東邦"},
                                      {name: "津田学園"},{name: "星稜"},{name: "啓新"},{name: "龍谷大平安"},
                                      {name: "福知山成美"},{name: "履正社"},{name: "明石商業"},{name: "市立和歌山"},
                                      {name: "智弁和歌山"},{name: "広陵"},{name: "呉"},{name: "米子東"},{name: "高松商業"},
                                      {name: "松山聖陵"},{name: "筑陽学園"},{name: "明豊"},{name: "大分"},
                                      {name: "日章学園"},{name: "石岡第一"},{name: "富岡西"},{name: "熊本西"}])

tournament = Category.create(name: "第101回全国高校野球選手権大会")
school1 = tournament.children.create([{name: "旭川大"},{name: "北照"},{name: "八戸学院光星"},{name: "花巻東"},
                                      {name: "秋田中央"},{name: "鶴岡東"},{name: "仙台育英"},{name: "聖光学院"},
                                      {name: "霞ヶ浦"},{name: "作新学院"},{name: "前橋育英"},{name: "花咲徳栄"},
                                      {name: "習志野"},{name: "関東第一"},{name: "國學院久我山"},{name: "東海大相模"},
                                      {name: "山梨学院"},{name: "静岡"},{name: "誉"},{name: "中京学院大中京"},
                                      {name: "津田学園"},{name: "日本文理"},{name: "飯山"},{name: "高岡商業"},
                                      {name: "星稜"},{name: "敦賀気比"},{name: "近江"},{name: "立命館宇治"},
                                      {name: "履正社"},{name: "明石商業"},{name: "智弁学園"},{name: "智弁和歌山"},
                                      {name: "岡山学芸館"},{name: "広島商業"},{name: "米子東"},{name: "石見智翠館"},
                                      {name: "宇部鴻城"},{name: "高松商業"},{name: "鳴門"},{name: "宇和島東"},
                                      {name: "明徳義塾"},{name: "筑陽学園"},{name: "佐賀北"},{name: "海星"},
                                      {name: "熊本工業"},{name: "藤蔭"},{name: "富島"},{name: "神村学園"},
                                      {name: "沖縄尚学"}])

tournament3 = Category.create(name: "2020年甲子園高校野球交流試合")
school1 = tournament3.children.create([{name: "白樺学園"},{name: "仙台育英"},{name: "鶴岡東"},
                                      {name: "健大高崎"},{name: "桐生第一"},{name: "花咲徳栄"},{name: "東海大相模"},
                                      {name: "山梨学院"},{name: "国士舘"},{name: "中京大中京"},{name: "県立岐阜商"},
                                      {name: "加藤学園"},{name: "星稜"},{name: "日本航空石川"},{name: "天理"},
                                      {name: "大阪桐蔭"},{name: "履正社"},{name: "智弁学園"},{name: "明石商業"},
                                      {name: "智弁和歌山"},{name: "倉敷商業"},{name: "鳥取城北"},{name: "広島新庄"},{name: "明徳義塾"},
                                      {name: "尽誠学園"},{name: "明豊"},{name: "創成館"},{name: "大分商業"},
                                      {name: "鹿児島城西"},{name: "帯広農業"},{name: "磐城"},{name: "平田"}])

tournament4 = Category.create(name: "第93回選抜高校野球大会")
school1 = tournament4.children.create([{name: "北海"},{name: "仙台育英"},{name: "柴田"},{name: "健大高崎"},
                                      {name: "常総学院"},{name: "専大松戸"},{name: "東海大菅生"},{name: "東海大相模"},
                                      {name: "東海大甲府"},{name: "中京大中京"},{name: "県岐阜商"},{name: "敦賀気比"},
                                      {name: "上田西"},{name: "智弁学園"},{name: "大阪桐蔭"},{name: "京都国際"},
                                      {name: "市立和歌山"},{name: "神戸国際大付"},{name: "天理"},{name: "広島新庄"},
                                      {name: "下関国際"},{name: "鳥取城北"},{name: "明徳義塾"},{name: "聖カタリナ学園"},{name: "大崎"},
                                      {name: "福岡大大濠"},{name: "明豊"},{name: "宮崎商業"},{name: "八戸西"},
                                      {name: "三島南"},{name: "東播磨"},{name: "具志川商"}])
                                       
User.create!(nickname: "yakumo",
             email: ENV['EMAIL'],
             password: ENV['PASSWORD'],
             password_confirmation: ENV['PASSWORD'] ,
             admin: true)

Tweet.create(title: "勝負を分けた初回の攻防",round: "1回戦",text: "1回表の攻防がすべてだった。誉の先発、左腕の杉本 恭一（3年）に対し、八戸学院光星は1番武岡 龍世（3年）が死球で出塁、2番がバントで送り、3番近藤 遼一（3年）が四球、2死後に5番大江 拓輝（3年）が死球で満塁とし、6番下山 昂大（3年）が1ストライク後の2球目を振り抜くと打球は左中間に飛び込む満塁ホームランとなり、早々と4点を先制した。そのまま光星が優位に進め勝利",
             school_a_score: "9",school_b_score: "0",school_a_id: 37,school_b_id: 53,tournament_id: 34,user_id: 1)

Tweet.create(title: "八戸学院光星、壮絶な打撃戦を制す",round: "2回戦",text: "八戸学院光星が練習試合で2度負けている智弁学園に勝利。壮絶な打撃戦を制した中でも光った横山、山田の2投手。横山は左投手には珍しく、三塁側に立って投げることにより、右打者のチェンジアップがかなり効いており、高めのストレートでも空振りを奪うことができており、ピッチングの幅も広い。また2番手としてマウンドに登ったエースの山田 怜卓も初戦と比べても力が入っていた。コンスタントに常時140キロ～143キロのストレートを投げ込み、自己最速タイの145キロを計測。",
             school_a_score: "10",school_b_score: "8",school_a_id: 37,school_b_id: 65,tournament_id: 34,user_id: 1)

Tweet.create(title: "スーパー１年生・笹倉が3回無失点の好リリーフ",round: "2回戦",text: "4回まで6対5の接戦の中、仙台育英が突き放した一戦。仙台育英のエース・大栄 陽斗が好投が大きかった。鳴門が追い上げた4回裏に登板。適時打を浴びたが、その後は常時140キロ前後（最速142キロ）のストレート、120キロ後半の縦スライダー、スライダーを低めに集める投球で、計3回を投げ、3奪三振、1四死球、1失点の好投。この試合のピッチングについて大栄は「今日はスライダーがあまりよくなかったので、ストレートをうまく投げ分けていきながら、勝負しました。」とその日の投球内容に合わせて配球を組み立てた。",
             school_a_score: "8",school_b_score: "5",school_a_id: 41,school_b_id: 73,tournament_id: 34,user_id: 1)

Tweet.create(title: "星稜、投打で圧倒し、24年ぶりの決勝進出！",round: "準決勝",text: "星稜の奥川 恭伸が5回まで無失点の好投を見せている。1回表、先頭打者に安打を浴びたが、後続をしっかりと締めると、2回以降は最速153キロ・常時145キロ～150キロの直球、130キロ前半のスライダー、130キロ前後のチェンジアップを織り交ぜ、7回まで投げて10奪三振、2安打、無四球、無失点の快投を見せた。こうして中京学院大中京を圧倒した星稜。奥川以外の投手陣の成長が奥川の負担を減らし、準決勝でも精度が高いピッチングを見せることができている。",
             school_a_score: "9",school_b_score: "0",school_a_id: 59,school_b_id: 54,tournament_id: 34,user_id: 1)

Tweet.create(title: "智辯和歌山がビッグイニングで逆転",round: "2回戦",text: "1点を追いかける7回、1イニング3ホームランで打線が大爆発し逆転勝利！今大会屈指の強力打線と言える。智辯和歌山の先発・矢田 真那斗（2年）が粘り強い投球を見せた。インステップ気味に踏み出して、振りだす左のスリークォーター。常時125キロ～130キロ台のストレートを両サイドに投げ分け、110キロ台のチェンジアップ、カーブを低めに集める投球だった。",
             school_a_score: "9",school_b_score: "0",school_a_id: 59,school_b_id: 54,tournament_id: 34,user_id: 1)

Tweet.create(title: "矛vs盾",round: "1回戦",text: "強豪ひしめく近畿地区を強打で昨秋を制した天理。核弾頭・下林 源太に河西 陽路などのスラッガーが揃う。それに相対するのは中国地区でベスト4に入った守備が武器の広島新庄。2年生左腕・秋山 恭平などの投手陣を中心にリズムを作っていく。矛と盾の一戦は緊迫の一戦となった 序盤は高く浮いていたこともあり、2回に天理7番・田中 輝希のレフト前などでピンチを招き、味方のミスで失点。4回に広島新庄は1番・大可 尭明の犠牲フライなどで2対1と勝ち越しながらも、直後の守備でバッテリーミスで失点となかなか守り切れない。しかし次第に秋田の持ち味である低めに投げ込むことが出来るようになると、天理打者はバットが止まらず空振り。もしくは体制を崩された形でゴロやフライアウトが増えていった。ストライク先行でピッチングを展開できるようになり、広島新庄らしい守備からリズムを作る展開ができ始めた。　すると勝ち越したい広島新庄は5回に4番・杉井 秀斗の四球からチャンスを作り、6番・明光 竜之介の二塁打で3対2と勝ち越しに成功。8回には1番・大可のダメ押しとなるタイムリーで試合を決めて、最後は7回からマウンドに上がっていた2年生・秋山が天理打線に反撃を許さずにゲームセット。広島新庄が4対2で天理を下した。",
             school_a_score: "4",school_b_score: "2",school_a_id: 107,school_b_id: 99,tournament_id: 84,user_id: 1)

Tweet.create(title: "リズムに乗った倉敷商が仙台育英を下す！",round: "1回戦",text: "5回、後攻の倉敷商は一死満塁から3番・浅野大器が押し出しの四球を選び勝ち越し。2対1と仙台育英から一歩リードする。さらに4回途中からマウンドに上がっていた倉敷商のエース・永野 司の好投からリズムを作り、5回にも1点を追加する。こうすると倉敷商の勢いが止まらず6回には8番・永野のタイムリーで3対1。そして7回には7番・田村のタイムリーなどで6対1。一気に試合を決定づけた倉敷商が6対1で仙台育英を下した。",
             school_a_score: "6",school_b_score: "1",school_a_id: 105,school_b_id: 86,tournament_id: 84,user_id: 1)

Tweet.create(title: "注目対決は大阪桐蔭に軍配",round: "1回戦",text: "まさに激闘、死闘だといってもいい実力の拮抗した一戦だった。2018年に春夏連覇した大阪桐蔭。対するはアグレッシブベースボールを掲げ、2015年に日本一に輝いた東海大相模。東西の超名門が激突した。後半にゲームが大きく動き大阪桐蔭が辛勝！",
             school_a_score: "4",school_b_score: "2",school_a_id: 100,school_b_id: 91,tournament_id: 84,user_id: 1)

Tweet.create(title: "初出場同士の一戦",round: "1回戦",text: "「気のゆるみがあった8回に甘いボールを打たれました。加藤学園が凄かったです」。春夏通じて初の甲子園となった鹿児島城西。そこでエースとしてチームを牽引した八方 悠介が試合を振り返って語ったコメントだ。その八方を攻略したのが同じく春夏通じて初めて甲子園出場となった加藤学園。第1試合の興奮冷めやらぬ初出場同士の一戦はも1点を巡って緊張感ある試合展開だった。加藤学園の肥沼 竣はワインドアップから始動。癖のない綺麗な投球フォームをしており、バランスがよく安定感のある投球。ストレートに縦のスライダーを投げ分けて鹿児島城西を打たせて取るピッチングを展開していき、チームに勝利をもたらした",
             school_a_score: "3",school_b_score: "1",school_a_id: 96,school_b_id: 113,tournament_id: 84,user_id: 1)

Tweet.create(title: "投打ががっちり噛み合った明豊",round: "1回戦",text: "投打ともにチームを支えるタレントが揃う明豊と県立岐阜商の一戦。日が暮れて少し涼しくもなってきた甲子園は熱い試合が繰り広げられた。先攻をとった明豊は「打って出塁すれば点になると思ってとにかく出塁を考えました」と二死から3番・布施 心海のセンター前からきっかけを作る。すると、4番・小川 聖太のライト線に落とす二塁打で布施が一気にホームに生還。明豊が先取点をもぎ取った。明豊打線は2回にも2番・宮川 雄基のタイムリーで追加点を挙げて3対0とした明豊。明豊3番手・太田 虎次朗が9回に、県立岐阜商の注目スラッガー・佐々木 泰にホームランを許したものの、明豊が4対2で逃げ切り。県立岐阜商を下して公式戦をすべて終えた。",
             school_a_score: "4",school_b_score: "2",school_a_id: 110,school_b_id: 95,tournament_id: 84,user_id: 1)

Tweet.create(title: "東邦が個人力、組織力で圧倒し30年ぶりの全国制覇！",round: "決勝",text: "試合巧者の習志野の上をいく個人力と組織プレーが光った決勝戦だった。まず東邦は1回裏、3番・石川昂弥がバックスクリーンへ2ランを放ち、2点を先制する。さらに打撃好調の吉納翼の適時三塁打も飛び出し3点目を入れる。これまで数多くの好投手を攻略してきた習志野だが、制球力抜群の石川を攻略できなかった。またバントミス、走塁ミスも多かった。そしてヒット性の打球を巧みに裁く東邦の守備陣。石川もバント処理を軽快に裁き、投ゴロバント併殺がなんと2つ。着実に習志野を追い詰めていった。そして5回裏、再び石川。エース・飯塚 脩人が投じたスライダーを逃さず、本塁打を放つ。石川は連投となっても制球力が落ちる気配が見られない。内野手の堅い守備とポジショニングの良い守備が光った。シフトをしっかりと敷いてもその狙い通りにアウトにとれたのは内野手の硬い守備や石川の制球力の高さが生きている。最後まで安定した試合運びを続け、東邦が30年ぶりの優勝を決めた。",
             school_a_score: "6",school_b_score: "0",school_a_id: 12,school_b_id: 7,tournament_id: 1,user_id: 1)

Tweet.create(title: "対応力を見せた筑陽学園",round: "２回戦",text: "1回戦で24得点を取った強力打線の山梨学院と、厚い投手層を持つ筑陽学園の対戦。1回は筑陽学園が4番江原 佑哉（3年）のレフト方向への二塁打で先制すると、山梨学院は1死二塁後、3番野村がライト前に落として同点に追いつく。1対1の膠着状態が崩れたのは7回表だ。先頭の6番福岡 大真（3年）が右中間に二塁打を放ち、1死後、8番石川 湧喜（3年）がレフト前に運んで一、三塁とする。2死後に打席に立った1番中村 敢晴（2年）は2ストライクを取られたあとステップを踏み出さないノーステップ打法に切り替え、6球目のストレートをライナーでレフト前に弾き返し、待望の勝ち越し点を入れる。そのまま逃げ切り勝利",
             school_a_score: "3",school_b_score: "2",school_a_id: 27,school_b_id: 9,tournament_id: 1,user_id: 1)

Tweet.create(title: "継投が裏目に出た「神宮王者」",round: "２回戦",text: "札幌大谷の先発マウンドに登ったのは、背番号18を背負った身長197センチの左腕・阿部 剣友。球速こそ常時130キロ台前半であったが、197センチの身長から振り下ろすフォームは見るからに打ちづらそうで、1回戦で横浜投手陣を打ち崩した明豊打線を抑え込んでいく。5回に継投策に出た札幌大谷。だが、結果的にこの継投は裏目に出ることになった。太田は、その後二塁に進塁を許して二死二塁とすると、4番・野邊 優汰が右中間を真っ二つに破るタイムリースリーベースを浴び、先制点を許す。さらに5回裏、明豊の6番・山田 昭太のツーベースから一死三塁のピンチを招いた札幌大谷は、8番・若杉にセンター前タイムリーを浴び、決勝点を奪われ敗退。",
             school_a_score: "2",school_b_score: "1",school_a_id: 28,school_b_id: 2,tournament_id: 1,user_id: 1)

Tweet.create(title: "強打の光星に完封勝ち",round: "1回戦",text: "中国地区を制した広陵と東北地区を制した八戸学院光星。言わずと知れた超名門校同士が1回戦から激突。この一戦を見ようと球場には多くの観客が駆け付けた。広陵のエース河野が140キロ台のストレートとスライダー、そしてフォークをコーナーに集め八戸学院光星に完封勝ち！広陵は９年ぶりの春勝利となった。",
             school_a_score: "2",school_b_score: "0",school_a_id: 22,school_b_id: 4,tournament_id: 1,user_id: 1)

Tweet.create(title: "龍谷大平安が終盤に突き放す",round: "2回戦",text: "お互い延長戦を勝ち上がった龍谷大平安と盛岡大附の一戦。龍谷大平安が自慢のしぶとい野球で盛岡大附を突き放した。盛岡大附がこれほどの戦いを見せても、突き放す龍谷大平安は非常に強いチームへ成長している。",
             school_a_score: "9",school_b_score: "1",school_a_id: 16,school_b_id: 5,tournament_id: 1,user_id: 1)

Tweet.create(title: "鳥取城北が悲願の春初勝利",round: "1回戦",text: "秋季大会ではベスト4まで勝ち上がって選抜の切符をつかみ取った中国地区代表・鳥取城北。対するは静岡県大会ベスト4だったが、強豪・静岡を破るなど快進撃があった21世紀枠・三島南。両チームの一戦は三島南が先にゲームを動かした。2回、5番・山田駿のヒットをきっかけにチャンスを作ると、一死三塁から7番・富岡創の犠牲フライで三島南が先制。先にペースを握ったかのように思われたが、鳥取城北が黙っていなかった。5回に3番に座る注目打者・畑中 未来翔のタイムリーに加えて、守備の乱れで鳥取城北が3点を取り返し逆転。三島南は6回に4番・小堂湧貴のタイムリーで1点差に詰め寄ったが、9回にマウンドに上がった2番手・前田 銀治が鳥取城北につかまり3失点と勝負あり。鳥取城北が6対2で三島南を下して、選抜での初勝利を掴んだ。",
             school_a_score: "6",school_b_score: "2",school_a_id: 139,
             school_b_id: 147,tournament_id: 117,user_id: 1)

Tweet.create(title: "仙台育英が息詰まる投手戦を制す",round: "1回戦",text: "名門同士の１戦。非常に見応えのある試合でした。明徳義塾の代木は夏も楽しみなピッチャーです。",
             school_a_score: "1",school_b_score: "0",school_a_id: 119,school_b_id: 140,tournament_id: 117,user_id: 1)

Tweet.create(title: "21世紀枠最強の東播磨が大健闘",round: "1回戦",text: "強豪・明豊の歯車狂わせた東播磨の走力に称賛の声続出！敗れはしましたが10-9の大健闘。夏もぜひ見てみたいチームです！",
             school_a_score: "1",school_b_score: "0",school_a_id: 144,school_b_id: 148,tournament_id: 117,user_id: 1)

Tweet.create(title: "名門同士の試合は思わぬ大差",round: "2回戦",text: "中京大中京が打力で圧倒し常総学院を下す。常総のWエースがここまで打たれるとは思ってもいませんでした。",
             school_a_score: "15",school_b_score: "5",school_a_id: 127,school_b_id: 122,tournament_id: 117,user_id: 1)

Tweet.create(title: "石田投手が圧巻のピッチング",round: "準決勝",text: "東海大相模のエース石田が被安打3で、2試合連続完封。130キロ台後半の直球とスライダーをコースに投げ分け、三回1死から6者連続三振を奪うなど、計15奪三振。六回に1死三塁のピンチを招いたが、それまであまり投げていなかったチェンジアップを織り交ぜて切り抜けた。今大会初先発の天理の左腕、仲川は一回こそ球が浮いて3安打を浴びたが、二回以降は変化球が低めに決まりだし、八回まで粘投した。だが、準々決勝までの3試合で21得点の打線が、最後まで石田の速球を攻略できなかった。",
             school_a_score: "2",school_b_score: "0",school_a_id: 125,school_b_id: 136,tournament_id: 117,user_id: 1)

Analysis.create(title: "神宮覇者",text: "投手陣が豊富なチームで神宮大会の優勝校 エースの西原の制球力に不安はあるものの投手力が良く、明治神宮大会でも星稜に投げ勝った事で選抜でもダークホースに上がりそう",
                attack:"3",defensive:"4",pitcher:"5",comprehensive:"4",expectations:"4",school_id: 2,tournament_id: 1,user_id: 1)

Analysis.create(title: "強力打線で初Vへ",text: "九州大会準優勝。今年も伝統の強力打線が健在で優勝候補に挙げても良い。",
                attack:"5",defensive:"4",pitcher:"3",comprehensive:"4",expectations:"4",school_id: 28,tournament_id: 1,user_id: 1)

Analysis.create(title: "注目の投手陣",text: "中国チャンピオンの広島の名門。今年はレベルの高いピッチャーが３人いて、総合力も高く優勝候補だと思います。",
                attack:"4",defensive:"5",pitcher:"5",comprehensive:"5",expectations:"5",school_id: 22,tournament_id: 1,user_id: 1)

Analysis.create(title: "四国の古豪",text: "香川の名門高松商業。今年はコツコツネバネバのチームと言われています。得点力の高い打線にエースの香川のピッチングが噛み合えば強いチームです。",
                attack:"4",defensive:"4",pitcher:"4",comprehensive:"4",expectations:"4",school_id: 25,tournament_id: 1,user_id: 1)

Analysis.create(title: "プロ注目の奥川が牽引",text: "今年のナンバーワンピッチャーと言っても良い奥川に注目です。総合力が高く神宮準優勝、優勝候補筆頭ではないでしょうか？",
                attack:"4",defensive:"5",pitcher:"5",comprehensive:"5",expectations:"5",school_id: 14,tournament_id: 1,user_id: 1)

Analysis.create(title: "タレント揃いの横綱",text: "高校野球界屈指の名門。今年も投打にタレントが揃い優勝候補。投手は松浦、関戸、打は4番池田、5番前田に注目です。",
                attack:"5",defensive:"4",pitcher:"5",comprehensive:"5",expectations:"5",school_id: 132,tournament_id: 117,user_id: 1)

Analysis.create(title: "相変わらずの堅守",text: "伝統の堅守の明徳。今年もピッチャーを中心として守りが堅いです。エースの代木はなかなか打てないピッチャーです。課題はやはり打線か。",
                attack:"3",defensive:"5",pitcher:"4",comprehensive:"4",expectations:"4",school_id: 140,tournament_id: 117,user_id: 1)

Analysis.create(title: "近畿チャンピオン",text: "強打で近畿チャンピオンとなった名門。決勝では大阪桐蔭を下し総合力の高いチームです。",
                attack:"5",defensive:"4",pitcher:"3",comprehensive:"4",expectations:"5",school_id: 131,tournament_id: 117,user_id: 1)

Analysis.create(title: "近畿チャンピオン",text: "強打で近畿チャンピオンとなった名門。決勝では大阪桐蔭を下し総合力の高いチームです。",
                attack:"5",defensive:"4",pitcher:"3",comprehensive:"4",expectations:"5",school_id: 131,tournament_id: 117,user_id: 1)

Analysis.create(title: "左右エースで無傷の39連勝",text: "新チームになってから公式戦は負けなしのチーム。右腕の花田、左腕の秋山の投手陣は大会屈指の実力。基本守り勝つチームだが、打率は.367と守備力だけではないのが分かる。",
                attack:"3",defensive:"4",pitcher:"5",comprehensive:"4",expectations:"4",school_id: 137,tournament_id: 117,user_id: 1)

Analysis.create(title: "強打で春初勝利を狙う",text: "看板の打線は本塁打を連発する派手さはないが、粘り強い好打者がそろう。昨秋の公式戦はチーム打率3割6分6厘、1試合平均10得点。足を絡めた積極的な攻めもあり、中国大会で準優勝した",
                attack:"4",defensive:"3",pitcher:"3",comprehensive:"3",expectations:"4",school_id: 106,tournament_id: 84,user_id: 1)

Analysis.create(title: "桃太郎打線",text: "中国大会は打ち勝つ試合が多かった。打線は強力だがやや安定感の無い試合も気になる。投手陣が踏ん張れば上位まで行けそう。",
                attack:"4",defensive:"3",pitcher:"3",comprehensive:"3",expectations:"4",school_id: 105,tournament_id: 84,user_id: 1)

Analysis.create(title: "神宮覇者",text: "プロ注目の高橋を擁し神宮大会を制した。総合力が高く優勝候補です！",
                attack:"5",defensive:"5",pitcher:"5",comprehensive:"5",expectations:"5",school_id: 94,tournament_id: 84,user_id: 1)

Analysis.create(title: "目立ってないが強い",text: "あまり目立っていないが強力打線で東北準優勝。ダークホース的な存在になると思います。",
                attack:"4",defensive:"3",pitcher:"3",comprehensive:"4",expectations:"3",school_id: 87,tournament_id: 84,user_id: 1)

Analysis.create(title: "再び強力打線で挑む",text: "去年の選抜で24得点で勝った試合は記憶に新しい。今年もその強打で挑みます！",
                attack:"4",defensive:"4",pitcher:"3",comprehensive:"4",expectations:"3",school_id: 92,tournament_id: 84,user_id: 1)

Analysis.create(title: "攻撃的な守備",text: "攻撃的な守備が売りな堅守のチーム。今年も堅い守備に高い得点力で期待できるチームです。",
                attack:"3",defensive:"5",pitcher:"4",comprehensive:"4",expectations:"4",school_id: 45,tournament_id: 34,user_id: 1)

Analysis.create(title: "愛され続けた伝統校",text: "第１回から参加している伝統校の米子東が夏も甲子園に帰ってきた。総合力は高くないがキッチリとした野球をする印象です。",
                attack:"3",defensive:"3",pitcher:"3",comprehensive:"3",expectations:"3",school_id: 69,tournament_id: 34,user_id: 1)

Analysis.create(title: "夏に強い作新",text: "秋春は甲子園を逃しても夏には滅法強い作新学院。今年も強打で上位進出に期待がかかるチームです。",
                attack:"5",defensive:"4",pitcher:"3",comprehensive:"4",expectations:"5",school_id: 44,tournament_id: 34,user_id: 1)

Analysis.create(title: "公立最強",text: "選抜ベスト４の実力校。公立勢の中では今大会最強だと思います。2年生エースの中森に注目です。",
                attack:"4",defensive:"4",pitcher:"4",comprehensive:"5",expectations:"5",school_id: 64,tournament_id: 34,user_id: 1)

Analysis.create(title: "もう一度ミラクルを",text: "89回にがばい旋風を巻き起こし優勝した佐賀北。チーム力は高くないが当時もそうだった。今年も旋風を巻き起こして優勝してほしい。",
                attack:"3",defensive:"3",pitcher:"3",comprehensive:"2",expectations:"4",school_id: 77,tournament_id: 34,user_id: 1)

Forecast.create(text: "二人の投手による継投、打線が看板というよく似たチームの対戦。大阪ｖｓ東京では例年大阪勢が意地を見せる展開が多いがこの試合では履正社エースの清水の投球がカギを握る。関東一打線にビックイニングを作らせないことが重要。試合展開としては当たっている井上が先陣を切り絶えずリードして展開する試合運びで逃げ切りを図りたい。",
                round: "準々決勝",probability: "70",win_school_id: 63,lose_school_id: 48,tournament_id: 34,user_id: 1)

Forecast.create(text: "夏の甲子園初登場の富島が２年連続出場で昨年のチームより力がある敦賀気比に挑戦する構図。ポイントは富島エースの黒木の出来。笠島・黒田の投手力が安定する敦賀気比に対して黒木がライバル以上に好投すれば総合力の差は少なくなる。富島は注目のトップバッター松浦が攻撃面でチームを引っ張る活躍を見せたい。富島は、去年の選抜では星稜の奥川投手とも対戦しているが今回も同じ北陸勢との対戦となり借りを返し甲子園初勝利を挙げられるか。",
                round: "1回戦",probability: "80",win_school_id: 60,lose_school_id: 81,tournament_id: 34,user_id: 1)

Forecast.create(text: "選抜準優勝の習志野の優位は動かないが沖縄尚学は非常に粘りがあり初戦の相手としてはできれば避けたい相手。習志野はエースの飯塚が調子を維持し左腕の山内も安定感を増した。打線も根本が引っ張り中軸は勝負強い。沖縄尚学は左右の軟投派投手を擁するが中盤までは習志野打線を抑えるのが必要条件。打線も大物打ちはいないが予選では毎試合４点以上を挙げており投手力の良い習志野からも３，４点は奪って慌てさせることが出来れば勝機が出てくる。まずは沖縄尚学・投手陣の踏ん張りを期待したい。",
                round: "1回戦",probability: "70",win_school_id: 83,lose_school_id: 47,tournament_id: 34,user_id: 1)

Forecast.create(text: "初戦ともにエースが粘りの投球を見せ打線がしぶとく得点を挙げたチーム同士の対戦。初戦の怪我で登板が難しい岡山学芸館・丹羽投手。中川投手が一人で作新学院打線を抑えられるかが焦点。直球が１４０キロを超え強打の広島商を８安打５失点に抑えたがこの試合も同じぐらいの失点は覚悟しなければならないだろう。岡山学芸館打線も初戦１０安打を放ち特に上位が当たっているのが頼もしい。作新学院は林ー三宅の継投が考えられるが序盤でリードを許さなければ自分たちのペースで試合を運べそう。",
                round: "3回戦",probability: "90",win_school_id: 44,lose_school_id: 67,tournament_id: 34,user_id: 1)

Forecast.create(text: "ここまで影山投手が好投して打線の振りが鋭い鶴岡東の勢いが目立つがそろそろどちらかの勢いが落ちると予想する。関東一は土屋投手が２回戦は完投し制球に難はあるが球に力のある谷投手が万全の調整が出来たことが心強い。打線の得点力は互角と見ているので投手力の差が試合結果に直結しそう。鶴岡東は池田投手に８回、出来れば９回にスイッチできればこれまでの２試合のような必勝態勢となる。関東一は中盤までに影山投手を降板させられるかがポイントとなる。",
                round: "3回戦",probability: "70",win_school_id: 48,lose_school_id: 40,tournament_id: 34,user_id: 1)

Forecast.create(text: "総合力では健大が上回るが投手力にやや不安がある健大を試合巧者下関国際・坂原監督がそこを突けば下関にもチャンスはある。今大会の出場校の中でも指折りの破壊力を持つ打線の健大高崎は継投策の下関投手陣を早めに打ち込み、味方投手が失点しても余裕を持って試合を進められる展開にしたい。",
                round: "1回戦",probability: "80",win_school_id: 121,lose_school_id: 138,tournament_id: 117,user_id: 1)

Forecast.create(text: "初戦２点、２回戦１点と打線が湿りっぱなしの東海大相模が福岡大大濠の好投手・毛利に対してどう得点していくかが見どころ。互いに２回戦は大苦戦したのでこの試合は波に乗った方が案外スルスル行く可能性がある。ポイントは福岡大大濠の先発投手。２回戦でやや調子が落ち始めた毛利が３試合目も先発で行くのか控え投手を起用するのか、いずれにしても中盤まで東海打線を眠ったままにしておけるかが大濠勝利のカギ。",
                round: "準々決勝",probability: "80",win_school_id: 125,lose_school_id: 143,tournament_id: 117,user_id: 1)

Forecast.create(text: "東海大菅生は２回戦は最後にタイムリーが出て京都国際をうっちゃったが打線に今ひとつ繋がりを欠いている印象だ。中京大中京も畔柳投手が連投になるが松田投手の先発もにらみながらそれでも３点までには抑えるのではないかと予想。一方、エース本田が本調子では無い東海大菅生は中京打線を３，４点までに抑えられるかがポイントとなる。柱になる鈴木投手の踏ん張りが期待される",
                round: "準々決勝",probability: "70",win_school_id: 127,lose_school_id: 124,tournament_id: 117,user_id: 1)

Forecast.create(text: "東海大相模が総合力で上回る。初戦先発の石川が投手陣で石田と共に計算できるようになったのは大きな戦力増。打線も東海大甲府・若山投手には抑えられたが元来力はあり鳥取城北・広田投手もコントロールには気をつけたい。鳥取城北としては、序盤で東海に大量点が入ると一方的になる危険性もあるが、ビックイニングを作らせないように継投も含めて粘りの展開に持ち込めるか。",
                round: "2回戦",probability: "80",win_school_id: 125,lose_school_id: 139,tournament_id: 117,user_id: 1)

Forecast.create(text: "実力伯仲で予想が難しい一戦。ポイントはどちらの先発投手がより持ちこたえられるか。天理の達投手も長打力はある健大高崎戦では甘いところに行くと痛打を浴びそう。初戦好投した健大高崎・高松投手も打線のレベルが上がる天理相手だと後ろに回るか継投策になる可能性がある。打線は互角と見ているので投手陣の出来が試合を左右しそうだ。",
                round: "2回戦",probability: "60",win_school_id: 136,lose_school_id: 121,tournament_id: 117,user_id: 1)

Forecast.create(text: "ここまで不安視された「投手」で好調を維持する石川は「打」では若干不発気味。「投」では奥田投手の先発が予想されるのでこのゲームでは「打」で貢献したい。好調を維持する４番の熊田もタイムリーが欲しい。明石商は疲れが見える中森投手を来田をはじめ打線で早めに援護できるかどうか。３点ほどの接戦になれば準々決勝同様勝機も出てくる。中森投手が早めに崩れるようだと大差もあり得る",
                round: "準決勝",probability: "60",win_school_id: 12,lose_school_id: 19,tournament_id: 1,user_id: 1)

Forecast.create(text: "浮橋投手を中心に投打にバランスの良い富岡西が東海王者で投打に中心の石川が引っ張る強豪・東邦に挑む一戦。ポイントは東邦の先発投手。昨年に続き投手力に不安を抱える東邦だが富岡西も四国大会では打線が当たっていたので４，５点の取り合いになれば浮橋投手の踏ん張り次第で好ゲームになりそう。東邦は石川がバットでチームを引っ張りたい。",
                round: "1回戦",probability: "90",win_school_id: 12,lose_school_id: 32,tournament_id: 1,user_id: 1)

Forecast.create(text: "投手力が武器の両チームの対戦。明石商は中森・宮口の右腕、国士舘は白須・山崎の長身右腕と互いに２枚看板を擁し共に守りは堅い。安定感では明石商投手陣に分があるが２，３点を争う接戦になりそう。ポイントはやはり両チームとも打力。共にバント他、機動力を絡めて１点づつ積み重ねる攻撃だが明石商は来田、国士舘は黒沢の長打が勝敗を分けるカギになる可能性がある。",
                round: "1回戦",probability: "90",win_school_id: 19,lose_school_id: 11,tournament_id: 1,user_id: 1)

Forecast.create(text: "総合力で高松商が優位に立つ。市和歌山は初戦好投した岩本が打力のある高松商に対しても同じような投球に徹することが出来るかどうか。高松商は初戦で投げなかった中塚の先発もあるが左打者が多い市和歌山に対しては左の香川の連投がセオリーか。市和歌山としては先制点を奪ってエースの岩本を援護する試合展開にしたい。",
                round: "2回戦",probability: "80",win_school_id: 25,lose_school_id: 20,tournament_id: 1,user_id: 1)

Forecast.create(text: "習志野は山内、市和歌山は岩本といずれも左腕投手の先発を予想。初戦は両投手とも好投を見せたがこの試合も先発投手の出来が大きく影響しそう。打線は市和歌山の方が当たっているがリリーフ投手は習志野に分がある。習志野は根本選手の復帰が無ければ苦しいが３点を争う接戦が期待される。",
                round: "準々決勝",probability: "80",win_school_id: 7,lose_school_id: 20,tournament_id: 1,user_id: 1)

Forecast.create(text: "明徳義塾が鳥取城北に守り勝つと予想。鳥取城北としては得意の打撃戦に持ち込みたいところ。",
                round: "1回戦",probability: "80",win_school_id: 108,lose_school_id: 106,tournament_id: 84,user_id: 1)

Forecast.create(text: "近畿チャンピオンの天理は打力で上回るが、新庄の秋山が抑えると予想します",
                round: "1回戦",probability: "60",win_school_id: 107,lose_school_id: 99,tournament_id: 84,user_id: 1)

Forecast.create(text: "東西の名門対決。互角だが近年の大阪桐蔭の活躍を買います！",
                round: "1回戦",probability: "60",win_school_id: 100,lose_school_id: 91,tournament_id: 84,user_id: 1)

Forecast.create(text: "強打＋プロ注目の小林がいる智弁和歌山がリードする。尽誠学園としてはあまり失点したくない。",
                round: "1回戦",probability: "80",win_school_id: 104,lose_school_id: 109,tournament_id: 84,user_id: 1)

Forecast.create(text: "2019夏決勝の再現。履正社は今年もチーム力が高く優勝候補に上がっていただろう。星稜も北信越決勝で19得点で強打のチーム。レベルの高い戦いとなるでしょう。",
                round: "1回戦",probability: "70",win_school_id: 101,lose_school_id: 97,tournament_id: 84,user_id: 1)

Map.create(text: "商業施設も多く、買い物や飲食する場所にも困りません。例えば、横浜駅周辺であれば駅と直結している商業施設が複数ありますし、その中に飲食店や雑貨屋といったお店が揃っています。横浜駅に行けば大抵のものは揃うでしょう。横浜市内であれば大抵の駅は横浜駅につながっていますので、栄えた横浜駅周辺にまで足を延ばすのは苦ではありません。飲食店だけでなく、ボーリング場やカラオケ、映画館といった施設も揃っているので、遊ぶ場所にも困りません。",
           address: "横浜市",latitude: 35.4437,longitude: 139.638,school_id: 10,tournament_id: 1,user_id: 1)

Map.create(text: "上田市（うえだし）は、長野県の東部（東信地方）にある市です。東信地方および上田地域の中心都市で、長野県内では長野市、松本市に次ぐ3番目の規模の都市です。上田城、別所温泉などがあります。",
           address: "上田市",latitude: 36.4019,longitude: 138.249,school_id: 130,tournament_id: 117,user_id: 1)

Map.create(text: "鳥取県の西部に位置し、山陰最大級の商業都市であり「山陰の大阪」とも称されます。8月には「がいな祭り」が開催され、がいな万灯、がいな太鼓などで賑わいます。夏は全国的にも暑いほうで、冬は豪雪地帯のため雪が積もり少し不便です。",
           address: "米子市",latitude: 35.4281,longitude: 133.331,school_id: 69,tournament_id: 34,user_id: 1)