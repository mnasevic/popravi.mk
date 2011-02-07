class Comment < ActiveRecord::Base

  # Gravatar
  include Gravtastic
  gravtastic

  # Attr accessible
  attr_accessible :name, :email, :content

  # Associations
  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  # Validations
  validates_presence_of :content, :commentable_id, :commentable_type
  validates_format_of :email, :with => EMAIL_REG_EXP, :allow_blank => true

  def commenter_name
    if user
      user.name.present? ? user.name : 'Анонимен корисник'
    else
      name.present? ? name : 'Анонимен посетител'
    end
  end

  def commenter_avatar
    if user
      user.avatar(:s)
    elsif email.blank?
      "avatars/anonymous.png"
    else
      gravatar_url
    end
  end
end
