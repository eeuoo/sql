var cur = db.Books.find()
  
cur.forEach( c => { 
    c.price = Number(c.price);
    c.discount = Number(c.discount);
    db.Books.save(c)
});

db.Books.find()