class Block < ActiveRecord::Base
  attr_accessible :block_type, :title
  validates :title, presence: true
  validates :block_type, presence: true

  RESERVED_FIELDS = [ :title, :block_type, :extensions ]
  attr_accessible *RESERVED_FIELDS

  store :extensions

  # determine possible block types by reading config files
  cattr_accessor :block_types

  @@block_types = {}

  def self.add_block_type key, block_data
    @@block_types[key] = HashWithIndifferentAccess.new(block_data)
    @@block_types[key].each do |k,v|
      unless RESERVED_FIELDS.include? k.to_sym
        store_accessor :extensions, k.to_sym
      end
    end
  end

  # initialize
  Dir.glob(File.join(Rails.root, 'config', 'blocks','*_block.yml')).each do |f|
    puts "Reading #{f}"
    begin
      key = File.basename(f).gsub(/\.yml$/,'').classify
      add_block_type key, YAML.load(File.open(f))
   rescue Exception => ex
      puts ex
      Rails.logger.warn "Failed to import block #{f}"
      Rails.logger.warn ex
    end
  end  

  def template_name 
    self.block_type.tableize.singularize
  end
end
