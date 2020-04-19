module SpkrMaker
  def make_spkr
    spkr = Spkr.create!(
      user: current_user,
      tlk: @tlk,
      name: current_user.username,
      bio: current_user.bio,
      biog: ActionView::Base.full_sanitizer.sanitize(current_user.biog.to_s),
      side: @tlk.non_hidden_spkrs.count.even? ? 'left' : 'right',
      color: choose_color(@tlk)
    )
    send_tlk_spkr_tlk_joined_mail unless spkr.user == @tlk.user
    send_tlk_owner_spkr_joined_mail unless @requesting_spkr.present? || spkr.user == @tlk.user
  end

  def make_remote_spkr(user)
    spkr = Spkr.create!(
      user: user,
      tlk: @new_tlk,
      name: user.username,
      bio: user.bio,
      biog: ActionView::Base.full_sanitizer.sanitize(user.biog.to_s),
      side: @new_tlk.spkrs.length.even? ? 'left' : 'right',
      color: choose_color(@new_tlk)
    )
  end

  def spkr_sides_update(tlk)
    i = 0
    tlk.spkrs.each do |spkr|
      unless spkr.hide == true
        i.even? ? spkr.side = 'left' : spkr.side = 'right'
        spkr.save!
        i += 1
      end
    end
  end

  private

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

  def send_tlk_spkr_tlk_joined_mail
    mail = TlkMailer.with(
      tlk: @tlk,
      user: current_user
    ).tlk_spkr_tlk_joined
    mail.deliver_later
  end

  def send_tlk_owner_spkr_joined_mail
    mail = TlkMailer.with(
      tlk: @tlk,
      user: @tlk.user,
      joined_user: current_user
    ).tlk_owner_tlk_joined
    mail.deliver_later
  end
end
