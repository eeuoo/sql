var meet = db.Song.findOne({name:'singer1'})


meet.albums = [1,2,3]

db.Song.save(meet)

db.Song.update({name:"singer1"},
               {$set:{album:[{title:"24/7",albumId:1},
                             {title:"TT", albumId : 2}]
                     }
               })
               
               
db.Song.update({name:'singer1'}, { $unset : {"likecnt": 0} } )

