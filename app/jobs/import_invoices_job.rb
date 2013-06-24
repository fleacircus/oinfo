class ImportInvoicesJob < Struct.new(:user)

  def perform
    data = Hash.from_xml open('http://localhost/invoices.xml')

    # simple/incomplete import analysis
    data['invoices']['invoice'].each do |set|
      customer      = set.delete 'customer'
      distributor   = set.delete 'distributor'
      invoice_items = set.delete 'invoice_items'
      attachments   = set.delete 'attachments'

      rec = Invoice.new(set)
      rec.user_id        = user.id
      rec.mandator_id    = user.mandator_id

      invoice_items.each do |item|
        rec.invoice_items.build(item)
      end

      rec.save!
      #Delayed::Worker.logger.info YAML::dump rec
    end
  end

end
