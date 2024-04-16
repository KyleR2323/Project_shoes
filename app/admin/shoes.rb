ActiveAdmin.register Shoe do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :shoe_model, :shoe_type, :quantity_available, :gender, :size, :color, :material, :price, :description, :sale_price_id, :brand_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:shoe_model, :shoe_type, :quantity_available, :gender, :size, :color, :material, :price, :description, :sale_price_id, :brand_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  remove_filter :image_attachment, :image_blob

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :brand, as: :select, collection: Brand.pluck(:brand_name, :id), prompt: "Select a Brand" # Display brand names in dropdown
      f.input :shoe_model
      f.input :shoe_type
      f.input :quantity_available
      f.input :gender
      f.input :size
      f.input :color, as: :string, label: "Color"
      f.input :material
      f.input :price
      f.input :sale_price, as: :select, collection: SalePrice.pluck(:sale_price, :id), prompt: "Sale Price" # Customize label for sale_price
      f.input :description
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image, size: "100x100") : ""
    end

    f.actions
  end

end
