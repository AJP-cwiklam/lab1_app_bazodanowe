class CreateKodyPocztowes < ActiveRecord::Migration[6.1]
  def change
    create_table :kody_pocztowe do |t|
      t.string :kod_pocztowy
      t.string :adres
      t.string :miejscowosc
      t.string :wojewodztwo
      t.string :powiat

      t.timestamps
    end
  end
end
