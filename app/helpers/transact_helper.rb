module TransactHelper

  def full_address(address)
    "#{address.prefecture.name}#{address.city}#{address.street}"
  end

  def full_name(address)
    content_tag :span, style: 'font-weight: bold' do
      "#{address.first_name} #{address.last_name}"
    end
  end

end