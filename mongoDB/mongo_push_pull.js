var s3 = db.Song.findOne({'name': 'singer3'})


db.Song.update({'name' : 'singer3'}, 
               { $push : { 'albums' : 10}
                })
                
s3

for(let i=100; i<=110; i++){
    db.Song.update({'name':'singer4'},
                { $addToSet: {'albums' : {$each : [i]} }            
                })
}

db.Song.findOne({'name' : 'singer4'})


db.Song.update({'name' : 'singer4'},
                { $pull : { 'albums' : 105 } 
                })
   
db.Song.update({name : 'singer4'},
                 {$pull : {albums : {$lte : 103} } } )  
                 
db.Song.update({name : 'singer4'},
                {$pull : {albums : {$in: [107, 109] } } 
                })

db.Song.findOne({'name' : 'singer4'})



