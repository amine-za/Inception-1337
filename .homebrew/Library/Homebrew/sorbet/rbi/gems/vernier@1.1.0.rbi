# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `vernier` gem.
# Please instead update this file by running `bin/tapioca gem vernier`.


# source://vernier//lib/vernier/version.rb#3
module Vernier
  class << self
    # source://vernier//lib/vernier.rb#17
    def profile(mode: T.unsafe(nil), **collector_options); end

    # source://vernier//lib/vernier.rb#17
    def run(mode: T.unsafe(nil), **collector_options); end

    # source://vernier//lib/vernier.rb#38
    def start_profile(mode: T.unsafe(nil), **collector_options); end

    # source://vernier//lib/vernier.rb#50
    def stop_profile; end

    # source://vernier//lib/vernier.rb#17
    def trace(mode: T.unsafe(nil), **collector_options); end

    # source://vernier//lib/vernier.rb#59
    def trace_retained(**profile_options, &block); end
  end
end

# source://vernier//lib/vernier/collector.rb#7
class Vernier::Collector
  # @return [Collector] a new instance of Collector
  #
  # source://vernier//lib/vernier/collector.rb#8
  def initialize(mode, options = T.unsafe(nil)); end

  # source://vernier//lib/vernier/collector.rb#49
  def add_marker(name:, start:, finish:, thread: T.unsafe(nil), phase: T.unsafe(nil), data: T.unsafe(nil)); end

  # Get the current time.
  #
  # This method returns the current time from Process.clock_gettime in
  # integer nanoseconds.  It's the same time used by Vernier internals and
  # can be used to generate timestamps for custom markers.
  #
  # source://vernier//lib/vernier/collector.rb#45
  def current_time; end

  # Record an interval with a category and name.  Yields to a block and
  # records the amount of time spent in the block as an interval marker.
  #
  # source://vernier//lib/vernier/collector.rb#61
  def record_interval(category, name = T.unsafe(nil)); end

  def sample; end
  def stack_table; end
  def start; end

  # source://vernier//lib/vernier/collector.rb#74
  def stop; end

  private

  # source://vernier//lib/vernier/collector.rb#30
  def add_hook(hook); end

  def finish; end
  def markers; end

  class << self
    def _new(_arg0, _arg1); end

    # source://vernier//lib/vernier.rb#64
    def new(mode, options = T.unsafe(nil)); end
  end
end

# source://vernier//lib/vernier.rb#13
class Vernier::Error < ::StandardError; end

# source://vernier//lib/vernier/hooks.rb#4
module Vernier::Hooks; end

# source://vernier//lib/vernier/hooks/active_support.rb#5
class Vernier::Hooks::ActiveSupport
  # @return [ActiveSupport] a new instance of ActiveSupport
  #
  # source://vernier//lib/vernier/hooks/active_support.rb#155
  def initialize(collector); end

  # source://vernier//lib/vernier/hooks/active_support.rb#182
  def disable; end

  # source://vernier//lib/vernier/hooks/active_support.rb#159
  def enable; end

  # source://vernier//lib/vernier/hooks/active_support.rb#187
  def firefox_marker_schema; end
end

# source://vernier//lib/vernier/hooks/active_support.rb#6
Vernier::Hooks::ActiveSupport::FIREFOX_MARKER_SCHEMA = T.let(T.unsafe(nil), Array)

# source://vernier//lib/vernier/hooks/active_support.rb#148
Vernier::Hooks::ActiveSupport::SERIALIZED_KEYS = T.let(T.unsafe(nil), Hash)

# source://vernier//lib/vernier/marker.rb#6
module Vernier::Marker
  class << self
    # Return an array of marker names.  The index of the string maps to the
    # value of the corresponding constant
    #
    # source://vernier//lib/vernier/marker.rb#34
    def name_table; end
  end
end

# source://vernier//lib/vernier/marker.rb#13
Vernier::Marker::MARKER_STRINGS = T.let(T.unsafe(nil), Array)

# source://vernier//lib/vernier/marker.rb#7
Vernier::Marker::MARKER_SYMBOLS = T.let(T.unsafe(nil), Array)

module Vernier::Marker::Phase; end
Vernier::Marker::Phase::INSTANT = T.let(T.unsafe(nil), Integer)
Vernier::Marker::Phase::INTERVAL = T.let(T.unsafe(nil), Integer)
Vernier::Marker::Phase::INTERVAL_END = T.let(T.unsafe(nil), Integer)
Vernier::Marker::Phase::INTERVAL_START = T.let(T.unsafe(nil), Integer)
module Vernier::Marker::Type; end
Vernier::Marker::Type::GC_END_MARK = T.let(T.unsafe(nil), Integer)
Vernier::Marker::Type::GC_END_SWEEP = T.let(T.unsafe(nil), Integer)
Vernier::Marker::Type::GC_ENTER = T.let(T.unsafe(nil), Integer)
Vernier::Marker::Type::GC_EXIT = T.let(T.unsafe(nil), Integer)
Vernier::Marker::Type::GC_PAUSE = T.let(T.unsafe(nil), Integer)
Vernier::Marker::Type::GC_START = T.let(T.unsafe(nil), Integer)
Vernier::Marker::Type::GVL_THREAD_EXITED = T.let(T.unsafe(nil), Integer)
Vernier::Marker::Type::GVL_THREAD_STARTED = T.let(T.unsafe(nil), Integer)
Vernier::Marker::Type::THREAD_RUNNING = T.let(T.unsafe(nil), Integer)
Vernier::Marker::Type::THREAD_STALLED = T.let(T.unsafe(nil), Integer)
Vernier::Marker::Type::THREAD_SUSPENDED = T.let(T.unsafe(nil), Integer)

# source://vernier//lib/vernier/middleware.rb#2
class Vernier::Middleware
  # @return [Middleware] a new instance of Middleware
  #
  # source://vernier//lib/vernier/middleware.rb#3
  def initialize(app, permit: T.unsafe(nil)); end

  # source://vernier//lib/vernier/middleware.rb#8
  def call(env); end
end

# source://vernier//lib/vernier/output/firefox.rb#7
module Vernier::Output; end

# https://profiler.firefox.com/
# https://github.com/firefox-devtools/profiler/blob/main/src/types/profile.js
#
# source://vernier//lib/vernier/output/firefox.rb#10
class Vernier::Output::Firefox
  # @return [Firefox] a new instance of Firefox
  #
  # source://vernier//lib/vernier/output/firefox.rb#88
  def initialize(profile); end

  # source://vernier//lib/vernier/output/firefox.rb#93
  def output(gzip: T.unsafe(nil)); end

  private

  # source://vernier//lib/vernier/output/firefox.rb#106
  def data; end

  # source://vernier//lib/vernier/output/firefox.rb#153
  def marker_schema; end

  # Returns the value of attribute profile.
  #
  # source://vernier//lib/vernier/output/firefox.rb#104
  def profile; end
end

# source://vernier//lib/vernier/output/firefox.rb#11
class Vernier::Output::Firefox::Categorizer
  # @return [Categorizer] a new instance of Categorizer
  #
  # source://vernier//lib/vernier/output/firefox.rb#13
  def initialize; end

  # @yield [category]
  #
  # source://vernier//lib/vernier/output/firefox.rb#43
  def add_category(name:, **kw); end

  # Returns the value of attribute categories.
  #
  # source://vernier//lib/vernier/output/firefox.rb#12
  def categories; end

  # source://vernier//lib/vernier/output/firefox.rb#64
  def categorize(path); end

  # source://vernier//lib/vernier/output/firefox.rb#60
  def gem_path(*names); end

  # source://vernier//lib/vernier/output/firefox.rb#52
  def get_category(name); end

  # source://vernier//lib/vernier/output/firefox.rb#56
  def starts_with(*paths); end
end

# source://vernier//lib/vernier/output/firefox.rb#68
class Vernier::Output::Firefox::Categorizer::Category
  # @return [Category] a new instance of Category
  #
  # source://vernier//lib/vernier/output/firefox.rb#70
  def initialize(idx, name:, color:, matcher: T.unsafe(nil)); end

  # source://vernier//lib/vernier/output/firefox.rb#78
  def add_subcategory(**args); end

  # Returns the value of attribute color.
  #
  # source://vernier//lib/vernier/output/firefox.rb#69
  def color; end

  # Returns the value of attribute idx.
  #
  # source://vernier//lib/vernier/output/firefox.rb#69
  def idx; end

  # Returns the value of attribute matcher.
  #
  # source://vernier//lib/vernier/output/firefox.rb#69
  def matcher; end

  # @return [Boolean]
  #
  # source://vernier//lib/vernier/output/firefox.rb#82
  def matches?(path); end

  # Returns the value of attribute name.
  #
  # source://vernier//lib/vernier/output/firefox.rb#69
  def name; end

  # Returns the value of attribute subcategories.
  #
  # source://vernier//lib/vernier/output/firefox.rb#69
  def subcategories; end
end

# source://vernier//lib/vernier/output/firefox.rb#208
class Vernier::Output::Firefox::Thread
  # @return [Thread] a new instance of Thread
  #
  # source://vernier//lib/vernier/output/firefox.rb#211
  def initialize(ruby_thread_id, profile, categorizer, name:, tid:, samples:, weights:, markers:, started_at:, timestamps: T.unsafe(nil), sample_categories: T.unsafe(nil), stopped_at: T.unsafe(nil), allocations: T.unsafe(nil), is_main: T.unsafe(nil), is_start: T.unsafe(nil)); end

  # source://vernier//lib/vernier/output/firefox.rb#390
  def allocations_table; end

  # source://vernier//lib/vernier/output/firefox.rb#318
  def data; end

  # source://vernier//lib/vernier/output/firefox.rb#297
  def filter_filenames(filenames); end

  # source://vernier//lib/vernier/output/firefox.rb#470
  def frame_table; end

  # source://vernier//lib/vernier/output/firefox.rb#494
  def func_table; end

  # Returns the value of attribute is_start.
  #
  # source://vernier//lib/vernier/output/firefox.rb#209
  def is_start; end

  # source://vernier//lib/vernier/output/firefox.rb#350
  def markers_table; end

  # Returns the value of attribute profile.
  #
  # source://vernier//lib/vernier/output/firefox.rb#209
  def profile; end

  # source://vernier//lib/vernier/output/firefox.rb#409
  def samples_table; end

  # source://vernier//lib/vernier/output/firefox.rb#445
  def stack_table; end

  # source://vernier//lib/vernier/output/firefox.rb#519
  def string_table; end

  private

  # source://vernier//lib/vernier/output/firefox.rb#525
  def gc_category; end

  # source://vernier//lib/vernier/output/firefox.rb#529
  def thread_category; end
end

# source://vernier//lib/vernier/output/top.rb#5
class Vernier::Output::Top
  # @return [Top] a new instance of Top
  #
  # source://vernier//lib/vernier/output/top.rb#6
  def initialize(profile); end

  # source://vernier//lib/vernier/output/top.rb#10
  def output; end
end

# source://vernier//lib/vernier/result.rb#2
class Vernier::Result
  # source://vernier//lib/vernier/result.rb#7
  def _stack_table; end

  # source://vernier//lib/vernier/result.rb#54
  def each_sample; end

  # source://vernier//lib/vernier/result.rb#46
  def elapsed_seconds; end

  # Returns the value of attribute end_time.
  #
  # source://vernier//lib/vernier/result.rb#15
  def end_time; end

  # Sets the attribute end_time
  #
  # @param value the value to set the attribute end_time to.
  #
  # source://vernier//lib/vernier/result.rb#15
  def end_time=(_arg0); end

  # Returns the value of attribute hooks.
  #
  # source://vernier//lib/vernier/result.rb#13
  def hooks; end

  # Sets the attribute hooks
  #
  # @param value the value to set the attribute hooks to.
  #
  # source://vernier//lib/vernier/result.rb#13
  def hooks=(_arg0); end

  # source://vernier//lib/vernier/result.rb#50
  def inspect; end

  # source://vernier//lib/vernier/result.rb#20
  def main_thread; end

  # Returns the value of attribute markers.
  #
  # source://vernier//lib/vernier/result.rb#11
  def markers; end

  # Returns the value of attribute meta.
  #
  # source://vernier//lib/vernier/result.rb#17
  def meta; end

  # Sets the attribute meta
  #
  # @param value the value to set the attribute meta to.
  #
  # source://vernier//lib/vernier/result.rb#17
  def meta=(_arg0); end

  # Returns the value of attribute mode.
  #
  # source://vernier//lib/vernier/result.rb#18
  def mode; end

  # Sets the attribute mode
  #
  # @param value the value to set the attribute mode to.
  #
  # source://vernier//lib/vernier/result.rb#18
  def mode=(_arg0); end

  # Returns the value of attribute pid.
  #
  # source://vernier//lib/vernier/result.rb#15
  def pid; end

  # Sets the attribute pid
  #
  # @param value the value to set the attribute pid to.
  #
  # source://vernier//lib/vernier/result.rb#15
  def pid=(_arg0); end

  # source://vernier//lib/vernier/result.rb#27
  def sample_categories; end

  # source://vernier//lib/vernier/result.rb#26
  def samples; end

  # source://vernier//lib/vernier/result.rb#146
  def stack(idx); end

  # source://vernier//lib/vernier/result.rb#3
  def stack_table=(stack_table); end

  # Realtime in nanoseconds since the unix epoch
  #
  # source://vernier//lib/vernier/result.rb#30
  def started_at; end

  # Returns the value of attribute threads.
  #
  # source://vernier//lib/vernier/result.rb#16
  def threads; end

  # Sets the attribute threads
  #
  # @param value the value to set the attribute threads to.
  #
  # source://vernier//lib/vernier/result.rb#16
  def threads=(_arg0); end

  # source://vernier//lib/vernier/result.rb#37
  def to_gecko(gzip: T.unsafe(nil)); end

  # source://vernier//lib/vernier/result.rb#150
  def total_bytes; end

  # TODO: remove these
  #
  # source://vernier//lib/vernier/result.rb#25
  def weights; end

  # source://vernier//lib/vernier/result.rb#41
  def write(out:); end
end

# source://vernier//lib/vernier/result.rb#63
class Vernier::Result::BaseType
  # @return [BaseType] a new instance of BaseType
  #
  # source://vernier//lib/vernier/result.rb#65
  def initialize(result, idx); end

  # Returns the value of attribute idx.
  #
  # source://vernier//lib/vernier/result.rb#64
  def idx; end

  # source://vernier//lib/vernier/result.rb#74
  def inspect; end

  # Returns the value of attribute result.
  #
  # source://vernier//lib/vernier/result.rb#64
  def result; end

  # source://vernier//lib/vernier/result.rb#70
  def to_s; end
end

# source://vernier//lib/vernier/result.rb#94
class Vernier::Result::Frame < ::Vernier::Result::BaseType
  # source://vernier//lib/vernier/result.rb#96
  def filename; end

  # source://vernier//lib/vernier/result.rb#99
  def func; end

  # source://vernier//lib/vernier/result.rb#95
  def label; end

  # source://vernier//lib/vernier/result.rb#104
  def line; end

  # source://vernier//lib/vernier/result.rb#95
  def name; end

  # source://vernier//lib/vernier/result.rb#108
  def to_s; end
end

# source://vernier//lib/vernier/result.rb#79
class Vernier::Result::Func < ::Vernier::Result::BaseType
  # source://vernier//lib/vernier/result.rb#85
  def filename; end

  # source://vernier//lib/vernier/result.rb#80
  def label; end

  # source://vernier//lib/vernier/result.rb#80
  def name; end

  # source://vernier//lib/vernier/result.rb#89
  def to_s; end
end

# source://vernier//lib/vernier/result.rb#113
class Vernier::Result::Stack < ::Vernier::Result::BaseType
  # source://vernier//lib/vernier/result.rb#114
  def each_frame; end

  # source://vernier//lib/vernier/result.rb#133
  def frames; end

  # source://vernier//lib/vernier/result.rb#129
  def leaf_frame; end

  # source://vernier//lib/vernier/result.rb#125
  def leaf_frame_idx; end

  # source://vernier//lib/vernier/result.rb#137
  def to_s; end
end

# source://vernier//lib/vernier/stack_table.rb#2
class Vernier::StackTable
  # source://vernier//lib/vernier/stack_table.rb#25
  def backtrace(stack_idx); end

  def convert(_arg0, _arg1); end
  def current_stack(*_arg0); end
  def frame_count; end
  def frame_func_idx(_arg0); end
  def frame_line_no(_arg0); end

  # source://vernier//lib/vernier/stack_table.rb#37
  def full_stack(stack_idx); end

  def func_count; end
  def func_filename(_arg0); end
  def func_first_lineno(_arg0); end
  def func_name(_arg0); end

  # source://vernier//lib/vernier/stack_table.rb#3
  def inspect; end

  def stack_count; end
  def stack_frame_idx(_arg0); end
  def stack_parent_idx(_arg0); end

  # source://vernier//lib/vernier/stack_table.rb#7
  def to_h; end

  class << self
    def new; end
  end
end

# Collects names of all seen threads
#
# source://vernier//lib/vernier/thread_names.rb#3
class Vernier::ThreadNames
  # @return [ThreadNames] a new instance of ThreadNames
  #
  # source://vernier//lib/vernier/thread_names.rb#4
  def initialize; end

  # source://vernier//lib/vernier/thread_names.rb#12
  def [](object_id); end

  # source://vernier//lib/vernier/thread_names.rb#16
  def finish; end

  private

  # source://vernier//lib/vernier/thread_names.rb#23
  def collect_running; end

  # source://vernier//lib/vernier/thread_names.rb#29
  def collect_thread(th); end

  # source://vernier//lib/vernier/thread_names.rb#33
  def pretty_name(thread); end
end

# source://vernier//lib/vernier/version.rb#4
Vernier::VERSION = T.let(T.unsafe(nil), String)
