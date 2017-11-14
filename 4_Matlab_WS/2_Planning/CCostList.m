classdef CCostList < handle
    properties
        mQ;
    end
    
    methods
        function ctor = CCostList()
            ctor.mQ = {}; 
        end
        
        function push(this, path)
            if(isempty(this.mQ))
                this.mQ = {path};
            else
                pushed_flag = 0;
                for k = 1:length(this.mQ)
                    if(this.mQ{k}.mCost > path.mCost)
                        this.mQ = [this.mQ(1:k-1), {path}, this.mQ(k:end)];
                        pushed_flag = 1;
                        break;
                    end
                end
                if(pushed_flag == 0)
                    this.mQ = [this.mQ, {path}];
                end
            end
        end
        
        function [n, flag] = pop(this)
            if(isempty(this.mQ))
                n    = 0;
                flag = 0;
            else
                n       = this.mQ{1};
                this.mQ = this.mQ(2:end);
                flag    = 1;
            end
        end
        
    end
end