db.food.insert({_id : 1, fruit : ['apple','banana','peach']})
db.food.insert({_id : 2, fruit : ['apple','orange','watermelon']})
db.food.insert({_id : 3, fruit : ['cherry','peach']})

db.food.find({ fruit : 'banana'})
db.food.find({ fruit : {$all : ['apple', 'banana']}}) // 'apple'과 'banana' 들어 있는 것 모두, 순서 무관
db.food.find({ "fruit.2" : 'peach'})  //index로 찾기
db.food.find({ fruit : {$size: 3}})  //크기로 찾기
  
  
  