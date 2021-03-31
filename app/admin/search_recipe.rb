ActiveAdmin.register_page "Search recipe" do
    content do
        panel "Search recipe by cards" do
            page_action :foo, method: :post do
                # do some logic using params['my_field']
                redirect_to "/"
            end
            
            content do
                form action: "my_custom_page/foo", method: :post do |f|
                    f.input :my_field, type: :text, name: 'my_field'
                    f.input :submit, type: :submit
                end
            end
        end
    end
end