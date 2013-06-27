class Accounting::InvoicesController < RestrictedAccess::Controller
  EXPORT_INCLUDE = [:customer, :distributor, :invoice_items,
                    :attachments => {:except => :file, :methods => :public_url}]

  def index
    respond_to do |format|
      format.html {
        @invoices_grid = initialize_grid(
          Invoice.accessible_by(current_ability),
          :include => [:customer, :distributor, :invoice_items, :attachments],
          :custom_order => {
            'invoices.customer_id'    => 'customers.name',
            'invoices.distributor_id' => 'distributors.name'
          }
        )
      }
      format.json {
        render json: Invoice.accessible_by(current_ability).to_json(:include => EXPORT_INCLUDE)
      }
      format.xml {
        render xml: Invoice.accessible_by(current_ability).to_xml(:include => EXPORT_INCLUDE)
      }
    end
  end


  def show
    respond_to do |format|
      format.html
      format.json {
        render json: @invoice.to_json(:include => EXPORT_INCLUDE)
      }
      format.xml {
        render xml: @invoice.to_xml(:include => EXPORT_INCLUDE)
      }
    end
  end

end
