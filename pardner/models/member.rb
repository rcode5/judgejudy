module Pardner
  class Member
    attr_reader :data

    EMAIL_TO_C5_SLACK_NAME_LUT = {
      'matt@carbonfive.com'  => '@matt',
      'ryanf@carbonfive.com' => '@ryan',
      'janet@carbonfive.com' => '@janet',
      'allie@carbonfive.com' => '@allie',
      'virginia@carbonfive.com' => '@virginia',
      'kristin@carbonfive.com' => '@kristin',
      'audrey@carbonfive.com' => '@audrey',
      'suzanna@carbonfive.com' => '@suzanna'
    }

    class << self
      def all
        @all ||= []
      end

      def find id
        all.find { |member| member.id == id }
      end

      def by_email email
        all.find { |member| member.email == email }
      end

      def slack_name(email)
        EMAIL_TO_C5_SLACK_NAME_LUT[email]
      end
    end

    def initialize data
      @data = data
      self.class.all.push self
    end

    def id
      data.id
    end

    def slack_name
      self.class.slack_name(email)
    end

    def email
      data.profile.email
    end

    def first_name
      data.profile.first_name
    end

    def real_name
      data.profile.real_name
    end

  end
end
