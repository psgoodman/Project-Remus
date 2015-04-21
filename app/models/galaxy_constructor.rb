class GalaxyConstructor

  def initialize(rings, base_faction)
    @faction = base_faction
    name_intake = CSV.read('lib/assets/names.csv')
    @names = []

    name_intake.each do |name|
      @names << name[0]
    end
    @systems = build_galaxy(rings)
  end

  attr_reader :systems

  def generate_system(ring)
    name = @names.sample
    @names.delete(name)
    max_census = rand(6) + rand(6) + 2
    raw = rand(10) + rand(10) + 2
    angle = rand
    System.new({
      name: name,
      census: 0,
      max_census: max_census,
      raw: raw,
      infrastructure: 0,
      ring: ring,
      angle: angle,
      faction: @faction
    })
  end

  def build_galaxy(rings)
    systems = build_rings(0, rings)
    systems
  end

  def build_rings(current_ring, max_rings)
    #Recursively generates rings of systems, returning an array
    #of arrays, each one containing the systems of one ring.
    #"Incoming links" and "links down" are lies/metaphors
    systems = []
    ring_systems = []
    if current_ring == 0
      ring_systems.push(generate_system(0))
    else
      (current_ring * 5 - rand(current_ring*3)).times do
        ring_systems.push(generate_system(current_ring))
      end
    end

    decompress(ring_systems)

    systems.push ring_systems

    unless current_ring == max_rings
      systems += build_rings(current_ring + 1, max_rings)
    end

    systems
  end

  def decompress(ring)
    ring.sort_by! { |system| system.angle}
    previous = nil
    ring.each do |system|
      if previous.class == System
        until (system.angle - previous.angle) > 0.13 / system.ring
          system.angle += 0.01 / system.ring
        end
        if system.angle > 1.0
          system.angle -= 1.0
        end
      end
      previous = system
    end
  end

end
