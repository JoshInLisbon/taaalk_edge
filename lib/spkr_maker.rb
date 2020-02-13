module SpkrMaker
  def make_spkr
    spkr = Spkr.create!(
      user: current_user,
      tlk: @tlk,
      name: current_user.username,
      bio: current_user.bio,
      biog: current_user.biog
    )
  end

  def make_remote_spkr(user)
    spkr = Spkr.create!(
      user: user,
      tlk: @tlk,
      name: user.username,
      bio: user.bio,
      biog: user.biog
    )
  end
end
