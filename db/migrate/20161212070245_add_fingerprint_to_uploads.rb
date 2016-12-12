class AddFingerprintToUploads < ActiveRecord::Migration[5.0]
  def change
    add_column :uploads, :fingerprint, :string
  end
end
