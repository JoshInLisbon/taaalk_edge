class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def terms
    @pop = "pop"
    @title = "Terms of Service"
  end

  def privacy
    @pop = "pop"
    @title = "Privacy Policy"
    @colours = %w(#C62828 #F44336 #EF9A9A #FFCDD2 #AD1457 #E91E63 #F48FB1 #F8BBD0 #6A1B9A #9C27B0 #CE93D8 #E1BEE7 #4527A0 #673AB7 #B39DDB #D1C4E9 blue #283593 #3F51B5 #9FA8DA #C5CAE9 #1565C0 #2196F3 #81D4FA #BBDEFB #00838F #00BCD4 #80DEEA #B3E5FC #00695C #009688 #80CBC4 #B2EBF2 #00eb17 #388E3C #4CAF50 #A5D6A7 #689F38 #8BC34A #C5E1A5 #9E9D24 #CDDC39 #E6EE9C #F9A825 yellow #FFEB3B #FFF59D #FF6F00 #FFC107 #FFE082 red #EB0309 #FF5722 #FFAB91 #FFCCBC #4E342E #795548 #BCAAA4 #D7CCC8 #37474F #607D8B #B0BEC5 #CFD8DC black #212121 #424242 #616161 #9E9E9E #F5F5F5 white)
  end



end
