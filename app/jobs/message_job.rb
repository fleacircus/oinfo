class MessageJob < Struct.new(:user)

  def perform
    Message.create({
      :title   => 'Automatisch generierte Nachricht',
      :text    => 'Diese Nachricht wurde automatisch durch einen Hintergrundprozess erzeugt.',
      :user_id => user.id, :mandator_id => user.mandator_id
    })
  end

end
