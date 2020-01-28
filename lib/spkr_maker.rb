module SpkrMaker
  def make_spkr
    spkr = Spkr.create!(
      user: current_user,
      tlk: @tlk,
      name: current_user.username,
      bio: current_user.bio,
      biog: current_user.biog
    )
    # if current_user.image.present?
    #   ActiveStorage::Attachment.create!(
    #     name: 'image',
    #     record_type: 'Spkr',
    #     record_id: spkr.id,
    #     blob_id: current_user.image.id
    #   )
    # end
  end
end
