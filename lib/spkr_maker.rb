module SpkrMaker
  def make_spkr
    Spkr.create!(
      user: current_user,
      tlk: @tlk,
      name: current_user.username,
      bio: current_user.bio
    )
  end
end
