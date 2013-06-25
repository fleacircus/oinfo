class ImportInvoicesJob < Struct.new(:user_id, :mandator_id)

  def perform
    data = Hash.from_xml open('http://localhost/oinfo/invoices.xml')

    data['invoices']['invoice'].each do |set|

      # check if invoice already exists
      test = Invoice.where(
        :invoice_number => set['invoice_number'],
        :mandator_id    => self.mandator_id
      ).first

      if test.nil?
        # import analysis
        customer      = find_or_create(set.delete('customer'), Customer)
        distributor   = find_or_create(set.delete('distributor'), Distributor)
        invoice_items = set.delete 'invoice_items'
        attachments   = set.delete 'attachments'

        invoice = Invoice.new(set)
        invoice.user_id, invoice.mandator_id = self.user_id, self.mandator_id
        invoice.customer_id    = customer.id    if !customer.nil?
        invoice.distributor_id = distributor.id if !distributor.nil?

        invoice_items.each do |item|
          invoice.invoice_items.build(item)
        end

        if !attachments.nil?
          attachments.each do |attachment|
            invoice.attachments.build(attachment)
          end
        end

        invoice.save!
      end

    end
  end


  private

  def find_or_create(hash, model)
    if !hash.nil?
      instance = model.where(:name => hash['name'], :mandator_id => self.mandator_id).first
      if instance.nil?
        hash['user_id'],  hash['mandator_id'] = self.user_id, self.mandator_id
        instance = model.create(hash)
      end
      hash = instance
    end
    hash
  end

end
