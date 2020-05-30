class AddAttachmentImagemToBaseProducts < ActiveRecord::Migration[5.2]
  def self.up
    change_table :base_products do |t|
      t.attachment :imagem
    end
  end

  def self.down
    remove_attachment :base_products, :imagem
  end
end
