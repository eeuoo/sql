db.Song.find({})

var arr = []

for(var i=1; i <=100; i++){
    if (i % 5 == 0){
        arr.push('singer'+i)
    }
}

var cur = db.Song.find({name : {$in : arr}})

while (cur.hasNext()){
    var obj = cur.next() 
    obj.likecnt = 10 ;
    db.Song.save(obj)
}

/* var i = 0             forEach 사용하여 설정 

cur.forEach( s => {
    i++;
    if( i % 5 == 0){
        s.likecnt = 10;
        db.Song.save(s);
    }
}) */  


db.Song.find({name : {$in : arr}}, {name:1, likecnt:1, _id :0}).limit(5)