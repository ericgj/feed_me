module FeedMe

  class OPMLParser < AbstractParser
    
    def self.open(file)
      new(Nokogiri::XML(Kernel.open(file).read))
    end

    def initialize(xml)
      @xml = xml.root
    end

    property :title, :path => 'head/title'
    has_many :outlines, :path => 'body/outline', :use => :OPMLOutlineParser
  end
    
  class OPMLOutlineParser < AbstractParser
    property :title,       :path => '@title'
    property :text,        :path => '@text'
    property :type,        :path => '@type'
    property :created,     :path => '@created', :as => :time
    property :xml_url,     :path => '@xmlUrl'
    property :html_url,    :path => '@htmlUrl'
    property :description, :path => '@description'
    property :language,    :path => '@language'
    property :version,     :path => '@version'
    
    has_many :outlines,    :path => 'outline', :use => :OPMLOutlineParser
  end

end
