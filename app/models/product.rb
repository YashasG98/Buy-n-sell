class Product < ApplicationRecord

    validates :name, {presence:true}
    validates :cost,{presence:true,numericality: { only_integer: true }}
    validates :age,{numericality: { only_integer: true }}
    validates :image,{presence:true}

end
