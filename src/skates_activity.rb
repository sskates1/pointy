require 'ruboto/widget'
require 'ruboto/util/toast'
require 'forecast_io'

ruboto_import_widgets :Button, :LinearLayout, :TextView

# http://xkcd.com/378/

class SkatesActivity
  def onCreate(bundle)
      ForecastIO.configure do |configuration|
          configuration.api_key = 'this-is-your-api-key'
      end
    super
    set_title 'Domo arigato, Mr Ruboto!'

    self.content_view =
        linear_layout :orientation => :vertical do
          @text_view = text_view :text => 'Should I water my cactus?', :id => 42,
                                 :layout => {:width => :match_parent},
                                 :gravity => :center, :text_size => 48.0
          button :text => 'M-x butterfly',
                 :layout => {:width => :match_parent},
                 :id => 43, :on_click_listener => proc { check_weather }
        end
  rescue Exception
    puts "Exception creating activity: #{$!}"
    puts $!.backtrace.join("\n")
  end

  private

  def broken
    @text_view.text = 'No probably not. Connection problems'
  end

  def get_location
     # get longitude latitude of cactus
     return 37.8267, -122.423
  end

  def check_weather
      ForecastIO.configure do |configuration|
          configuration.api_key = 'this-is-your-api-key'
      end
      long, lat = get_location
      # get forcast of  long, lat
      forecast = ForecastIO.forecast(long, lat)
    # if raining
        #return rain
    # else
        #return no rain
    # end
  end

end
