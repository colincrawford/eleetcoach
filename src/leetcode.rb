require "net/http"
require "json"

module Leetcode
  module Difficulty
    EASY = "Easy"
    MEDIUM = "Medium"
    HARD = "Hard"
  end

  class Problem
    @@difficulty_map = {
      1 => Difficulty::EASY,
      2 => Difficulty::MEDIUM,
      3 => Difficulty::HARD
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
      diff = @@difficulty_map.fetch(@difficulty)
      return "Unknown" if diff.nil?
      diff
    end
  end

  class Client
    def initialize(logger:)
      @logger = logger
      # cache problems
      @problems = nil
    end

    def random_problem
      problems.sample
    end

    private

    def problems
      return @problems if @problems

      uri = URI("https://leetcode.com/api/problems/all/")
      resp = Net::HTTP.get(uri)
      json = JSON.parse(resp)
      problems = json["stat_status_pairs"]
      problems.map { |p| parse_problem(p) }
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
