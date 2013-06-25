class MessageJob < Struct.new(:user_id, :mandator_id)

  def perform
    Message.create({
      :title   => 'Automatisch generierte Nachricht',
      :text    => 'Diese Nachricht wurde automatisch durch einen Hintergrundprozess erzeugt.',
      :user_id => user_id, :mandator_id => mandator_id
    })
  end

end
