class Resume < ApplicationRecord
    belongs_to :user
    belongs_to :job
    validates :content,presence: {message: "必填項目"}
    mount_uploader :attachment, AttachmentUploader
end
