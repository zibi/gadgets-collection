class Image < ActiveRecord::Base
  belongs_to :gadget

  has_attached_file :content, styles: {thumb: "100x100#"}

  validates_attachment_content_type :content, :content_type => /\Aimage/
end
