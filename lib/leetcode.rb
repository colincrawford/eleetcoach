require "net/http"
require "json"

module Leetcode
  class Difficulty
    EASY = "Easy"
    MEDIUM = "Medium"
    HARD = "Hard"

    def self.parse(difficulty)
      case difficulty.downcase
      when 'easy'
        EASY
      when 'medium'
        MEDIUM
      when 'hard'
        HARD
      else
        nil
      end
    end
  end

  class Problem
    @@difficulty_map = {
      1 => Difficulty::EASY,
      2 => Difficulty::MEDIUM,
      3 => Difficulty::HARD
    }

    @@difficulty_level_map = {
      Difficulty::EASY => 1,
      Difficulty::MEDIUM => 2,
      Difficulty::HARD => 3
    }

    attr_reader :title, :id, :frontend_id

    def initialize(title:, slug:, id:, frontend_id:, difficulty:)
      @title = title
      @slug = slug
      @id = id
      @frontend_id = frontend_id
      @difficulty = difficulty
    end

    def link
      "https://leetcode.com/problems/#{@slug}/"
    end

    def difficulty
      difficulty = @@difficulty_map.fetch(@difficulty)
      return "Unknown" if difficulty.nil?
      difficulty
    end

    def meets_minimum_difficulty(minimum_difficulty)
      return true if minimum_difficulty.nil?
      @difficulty >= @@difficulty_level_map[minimum_difficulty]
    end

    def to_json
      JSON::dump({
        id: @id,
        title: @title,
        link: link,
        difficulty: difficulty
      })
    end
  end

  class Client
    def initialize(logger:)
      @logger = logger
      # cache problems
      @problems = nil
    end

    def random_problem(minimum_difficulty)
      problems.filter { |p| p.meets_minimum_difficulty(minimum_difficulty) }.sample
    end

    private

    def problems
      if @problems.nil?
        @problems = fetch_problems
      end
      @problems
    end

    def fetch_problems
      uri = URI("https://leetcode.com/api/problems/all/")
      resp = Net::HTTP.get(uri)
      json = JSON.parse(resp)
      json["stat_status_pairs"].map { |p| parse_problem(p) }
    end

    def parse_problem(json)
      title = json["stat"]["question__title"]
      slug = json["stat"]["question__title_slug"]
      question_id = json["stat"]["question_id"]
      frontend_question_id = json["stat"]["frontend_question_id"]
      difficulty = json["difficulty"]["level"]

      Problem.new(
        title: title,
        slug: slug,
        id: question_id,
        frontend_id: frontend_question_id,
        difficulty: difficulty
      )
    end
  end
end
