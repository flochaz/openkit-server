class Leaderboard < ActiveRecord::Base
  attr_accessible :name, :icon, :in_development, :sort_type
  attr_accessible :type
  validates_presence_of :name, :sort_type
  validates_uniqueness_of :name, :scope => :app_id

  belongs_to :app
  has_many :scores, :dependent => :delete_all

  def api_fields(base_uri)
    {
      :id => id,
      :app_id => app_id,
      :name => name,
      :created_at => created_at,
      :updated_at => updated_at,
      :in_development => in_development,
      :sort_type => sort_type,
      :icon_url => PaperclipHelper.uri_for(icon, base_uri),
      :player_count => player_count
    }
  end

  has_attached_file :icon, :default_url => 'http://ok-shared.s3-us-west-2.amazonaws.com/leaderboard_icon.png'

  HIGH_VALUE_SORT_TYPE = "HighValue"
  LOW_VALUE_SORT_TYPE = "LowValue"


  public
  def is_high_value?
    sort_type == HIGH_VALUE_SORT_TYPE
  end

  def is_low_value?
    sort_type == LOW_VALUE_SORT_TYPE
  end

  def player_count
    scores.count(:user_id, :distinct => true)
  end

  private
  def extrema_func_name
    sql_lookup[sort_type][:extrema_func_name]
  end

  def order_keyword
    sql_lookup[sort_type][:order_keyword]
  end

  def sql_lookup
    @sql_lookup ||= {
      HIGH_VALUE_SORT_TYPE => {
        :extrema_func_name => "MAX",
        :order_keyword => "DESC",
      },
      LOW_VALUE_SORT_TYPE => {
        :extrema_func_name => "MIN",
        :order_keyword => "ASC",
      }
    }
  end
end
