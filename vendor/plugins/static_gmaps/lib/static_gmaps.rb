# The MIT License
# 
# Copyright (c) 2008 John Wulff <johnwulff@gmail.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'net/http'

module StaticGmaps 
  VERSION = '0.0.3' 

  class Map
    MAXIMUM_URL_SIZE = 1978
    MAXIMUM_MARKERS  = 50
    DEFAULT_CENTER   = [ 0, 0 ]
    DEFAULT_ZOOM     = 1
    DEFAULT_SIZE     = [ 500, 400 ]
    DEFAULT_MAP_TYPE = :roadmap
    DEFAULT_KEY      = 'ABQIAAAAzr2EBOXUKnm_jVnk0OJI7xSosDVG8KKPE1-m51RBrvYughuyMxQ-i1QfUnH94QxWIa6N4U6MouMmBA'
    DEFAULT_MARKERS  = [ ]

    attr_accessor :center,
                  :zoom,
                  :size,
                  :map_type,
                  :key,
                  :markers

    def initialize(options = {})
      self.center   = options[:center]   || DEFAULT_CENTER
      self.zoom     = options[:zoom]     || DEFAULT_ZOOM
      self.size     = options[:size]     || DEFAULT_SIZE
      self.map_type = options[:map_type] || DEFAULT_MAP_TYPE
      self.key      = options[:key]      || DEFAULT_KEY
      self.markers  = options[:markers]  || DEFAULT_MARKERS
    end

    def width
      size[0]
    end

    def height
      size[1]
    end

    # http://code.google.com/apis/maps/documentation/staticmaps/index.html#URL_Parameters
    def url
      raise MissingArgument.new("Size must be set before a url can be generated for Map.") if !size || !size[0] || !size[1]
      raise MissingArgument.new("Key must be set before a url can be generated for Map.") if !key
      if !(markers && markers.size > 1)
        raise MissingArgument.new("Center must be set before a url can be generated for Map (or multiple markers can be specified).") if !center
        raise MissingArgument.new("Zoom must be set before a url can be generated for Map (or multiple markers can be specified).") if !zoom
      end
      raise "Google will not display more than #{MAXIMUM_MARKERS} markers." if markers && markers.size > MAXIMUM_MARKERS
      parameters = {}
      parameters[:size]     = "#{size[0]}x#{size[1]}"
      parameters[:key]      = "#{key}"
      parameters[:map_type] = "#{map_type}"               if map_type
      parameters[:center]   = "#{center[0]},#{center[1]}" if center
      parameters[:zoom]     = "#{zoom}"                   if zoom
      parameters[:markers]  = "#{markers_url_fragment}"   if markers_url_fragment
      parameters = parameters.to_a.sort { |a, b| a[0].to_s <=> b[0].to_s }
      parameters = parameters.collect { |parameter| "#{parameter[0]}=#{parameter[1]}" }
      parameters = parameters.join '&'
      x = "http://maps.google.com/staticmap?#{parameters}"
      raise "Google doesn't like the url to be longer than #{MAXIMUM_URL_SIZE} characters.  Try fewer or less precise markers." if x.size > MAXIMUM_URL_SIZE
      return x
    end
    
    def markers_url_fragment
      if markers && markers.any?
        return markers.collect{|marker| marker.url_fragment }.join('|')
      else
        return nil
      end
    end

    def to_blob
      fetch
      return @blob
    end

    private
      def fetch
        if !@last_fetched_url || @last_fetched_url != url || !@blob
          uri = URI.parse url
          request = Net::HTTP::Get.new uri.path
          response = Net::HTTP.start(uri.host, uri.port) { |http| http.request request }
          @blob = response.body
          @last_fetched_url = url
        end
      end
  end
  
  # http://code.google.com/apis/maps/documentation/staticmaps/index.html#Markers
  class Marker
    DEFAULT_LATITUDE        = nil
    DEFAULT_LONGITUDE       = nil
    DEFAULT_COLOR           = nil
    DEFAULT_ALPHA_CHARACTER = nil
    VALID_COLORS            = [ :red, :green, :blue ]
    VALID_ALPHA_CHARACTERS  = [ :a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l, :m, :n, :o, :p, :q, :r, :s, :t, :u, :v, :w, :x, :y, :z ]
    
    attr_accessor :latitude,
                  :longitude,
                  :color,
                  :alpha_character
    
    def initialize(options = {})
      self.latitude        = options[:latitude]        || DEFAULT_LATITUDE
      self.longitude       = options[:longitude]       || DEFAULT_LONGITUDE
      self.color           = options[:color]           || DEFAULT_COLOR
      self.alpha_character = options[:alpha_character] || DEFAULT_ALPHA_CHARACTER
    end
    
    def color=(value)
      if value
        value = value.to_s.downcase.to_sym
        if !VALID_COLORS.include?(value)
          raise ArgumentError.new("#{value} is not a supported color.  Supported colors are #{VALID_COLORS.join(', ')}.")
        end
      end
      @color = value
    end
    
    def alpha_character=(value)
      if value
        value = value.to_s.downcase.to_sym
        if !VALID_ALPHA_CHARACTERS.include?(value)
          raise ArgumentError.new("#{value} is not a supported alpha_character.  Supported colors are #{VALID_ALPHA_CHARACTERS.join(', ')}.")
        end
      end
      @alpha_character = value
    end
    
    def url_fragment
      raise MissingArgument.new("Latitude must be set before a url_fragment can be generated for Marker.") if !latitude
      raise MissingArgument.new("Longitude must be set before a url_fragment can be generated for Marker.") if !longitude
      x  = "#{latitude},#{longitude}"
      x += ",#{color}" if color
      x += "#{alpha_character}" if alpha_character
      return x
    end
  end
end