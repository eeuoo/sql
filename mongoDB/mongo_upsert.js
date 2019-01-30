for(var i=1; i <= 10; i++){
    db.Song.update({name : "singer" + i }, 
                    {$inc : {likecnt : 1} }, true )
}


db.Song.update( {likecnt : 1 }, 
				 {$inc: {likecnt: 1} },
				 true, true  )


db.Song.find()