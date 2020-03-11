module SpkrMaker
  def make_spkr
    spkr = Spkr.create!(
      user: current_user,
      tlk: @tlk,
      name: current_user.username,
      bio: current_user.bio,
      biog: current_user.biog,
      side: @tlk.spkrs.length.even? ? 'left' : 'right',
      color: choose_color(@tlk)
    )
  end

  def make_remote_spkr(user)
    spkr = Spkr.create!(
      user: user,
      tlk: @new_tlk,
      name: user.username,
      bio: user.bio,
      biog: user.biog,
      side: @new_tlk.spkrs.length.even? ? 'left' : 'right',
      color: choose_color(@new_tlk)
    )
  end

  def choose_color(tlk)
    colors = %w(green purple red orange black pink white blue yellow)
    if tlk.spkrs.present?
      if tlk.spkrs.length > 9
        colors.sample
      else
        tlk.spkrs.each do |spkr|
          colors.delete_if { |color| color == spkr.color }
        end
        colors.sample
      end
    else
      colors.sample
    end
  end
end
