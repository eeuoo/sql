var s = db.Song

for( let i = 1; i <= 100; i++){
    s.insert({title:'노래'+i, singer: "singer" + i})
}

db.Song.find()
  